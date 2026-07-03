// Integration Tests — Report Item / Feed <-> Firestore Round Trip
// Campus Lost & Found — SQE Semester Project
//
// WHY THIS HITS REAL FIRESTORE (not a fake):
// ItemsRecord.collection is hardwired to FirebaseFirestore.instance (see
// lib/backend/schema/items_record.dart, line ~29) — a global singleton with
// no dependency-injection point. The data layer cannot be isolated from a
// real backend without modifying production code. This tight coupling is
// itself a finding for the Software Inspection Report: it makes the
// codebase harder to unit-test and forces integration tests onto a real
// Firestore project.
//
// SAFETY — READ BEFORE RUNNING:
// This suite WRITES TO and DELETES FROM Firestore. Only run it against a
// disposable TEST Firebase project — never your dev or production project.
// See Test_Plan_Campus_Lost_Found.docx, Section 9 (Environmental Needs) and
// Section 11 (Risks), which already call this out. Every test cleans up
// after itself in tearDown(), but a crash mid-test could leave orphaned
// documents titled "INTEGRATION TEST - ..." — safe to manually delete if so.
//
// HOW TO RUN:
//   1. Confirm firebase_options.dart points at your TEST project (not prod).
//   2. Copy this file to test/report_item_integration_test.dart
//   3. flutter test test/report_item_integration_test.dart
//   4. Send back the full console output.

import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:campus_lost_found/backend/schema/items_record.dart';
import 'package:campus_lost_found/firebase_options.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final List<String> createdDocIds = [];

  setUpAll(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });

  tearDown(() async {
    for (final id in createdDocIds) {
      await ItemsRecord.collection.doc(id).delete().catchError((_) {});
    }
    createdDocIds.clear();
  });

  test(
    'INT-001: Submitting a lost item creates a matching Firestore document '
    '(FR-4.3, FR-4.4, FR-4.5)',
    () async {
      final docRef = ItemsRecord.collection.doc();
      createdDocIds.add(docRef.id);

      await docRef.set(createItemsRecordData(
        itemId: docRef.id,
        title: 'INTEGRATION TEST - Lost Wallet',
        type: 'lost',
        category: 'Wallet',
        description: 'Automated integration test item - safe to delete',
        location: 'Test Location',
        date: DateTime.now(),
        postedBy: 'integration-test-uid',
        postedByName: 'Integration Test',
        contactInfo: 'test@example.com',
        status: 'active',
        createdAt: DateTime.now(),
      ));

      final snapshot = await docRef.get();
      expect(snapshot.exists, isTrue);

      final record = ItemsRecord.fromSnapshot(snapshot);
      expect(record.title, 'INTEGRATION TEST - Lost Wallet');
      expect(record.type, 'lost');
      expect(record.status, 'active');
      expect(record.postedBy, 'integration-test-uid');
    },
  );

  test(
    'INT-002: Lost Items Feed query returns only type=lost items, newest '
    'first — mirrors the EXACT query in lost_items_feed_widget.dart (FR-5.1)',
    () async {
      final lostRef = ItemsRecord.collection.doc();
      final foundRef = ItemsRecord.collection.doc();
      createdDocIds.addAll([lostRef.id, foundRef.id]);

      await lostRef.set(createItemsRecordData(
        itemId: lostRef.id,
        title: 'INTEGRATION TEST - Lost Item',
        type: 'lost',
        status: 'active',
        createdAt: DateTime.now(),
      ));
      await foundRef.set(createItemsRecordData(
        itemId: foundRef.id,
        title: 'INTEGRATION TEST - Found Item',
        type: 'found',
        status: 'active',
        createdAt: DateTime.now(),
      ));

      final results = await queryItemsRecordOnce(
        queryBuilder: (q) => q
            .where('type', isEqualTo: 'lost')
            .orderBy('createdAt', descending: true),
      );

      final testResults =
          results.where((r) => r.title.startsWith('INTEGRATION TEST')).toList();
      expect(testResults.every((r) => r.type == 'lost'), isTrue);
      expect(
        testResults.any((r) => r.title == 'INTEGRATION TEST - Found Item'),
        isFalse,
      );
    },
  );

  test(
    'INT-003 [DOCUMENTS A REAL RISK]: An item created WITHOUT createdAt does '
    'not appear in the ordered feed query, because Firestore excludes '
    'documents missing an orderBy field from the result set',
    () async {
      final ref = ItemsRecord.collection.doc();
      createdDocIds.add(ref.id);

      // Intentionally omit createdAt.
      await ref.set(createItemsRecordData(
        itemId: ref.id,
        title: 'INTEGRATION TEST - No CreatedAt',
        type: 'lost',
        status: 'active',
      ));

      final results = await queryItemsRecordOnce(
        queryBuilder: (q) => q
            .where('type', isEqualTo: 'lost')
            .orderBy('createdAt', descending: true),
      );

      final found =
          results.any((r) => r.title == 'INTEGRATION TEST - No CreatedAt');
      // This assertion documents current Firestore behavior. The Report Item
      // screen DOES set createdAt on creation (verified in source), so this
      // risk is currently dormant — but any future code path that creates an
      // item without createdAt will make that item silently invisible in
      // every feed. Worth a defensive Firestore security rule or default.
      expect(found, isFalse);
    },
  );

  test(
    'INT-004: The Edit path (update) does not overwrite fields it omits — '
    'partial update semantics, mirrors report_item_widget.dart edit branch',
    () async {
      final ref = ItemsRecord.collection.doc();
      createdDocIds.add(ref.id);

      await ref.set(createItemsRecordData(
        itemId: ref.id,
        title: 'INTEGRATION TEST - Original Title',
        type: 'lost',
        category: 'Electronics',
        status: 'active',
        postedBy: 'uidX',
        createdAt: DateTime.now(),
      ));

      // Mirrors the EDIT branch in report_item_widget.dart, which only
      // passes title/type/category/description/location/contactInfo.
      await ref.update(createItemsRecordData(
        title: 'INTEGRATION TEST - Updated Title',
        category: 'Electronics',
      ));

      final snapshot = await ref.get();
      final record = ItemsRecord.fromSnapshot(snapshot);
      expect(record.title, 'INTEGRATION TEST - Updated Title');
      expect(record.postedBy, 'uidX'); // must be preserved, not wiped
      expect(record.status, 'active'); // must be preserved, not wiped
    },
  );
}