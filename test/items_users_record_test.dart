// Unit Tests — Data Model Layer (ItemsRecord, UsersRecord)
// Campus Lost & Found — SQE Semester Project
//
// HOW TO RUN THIS FILE (on your own machine, where Flutter is installed):
//   1. Copy this file into your project's `test/` folder, e.g.:
//        test/items_users_record_test.dart
//   2. Add the fake_cloud_firestore dev dependency (only needed for testing):
//        flutter pub add fake_cloud_firestore --dev
//   3. Run:
//        flutter test test/items_users_record_test.dart
//   4. Copy the full console output (including any FAILED blocks and stack
//      traces) and send it back so the real Unit Test Execution Report and
//      any resulting Defect Reports can be built from actual results.
//
// NOTE: Some tests below are intentionally written to assert the CORRECT/
// DESIRED behavior described in the SRS non-functional requirements, not
// necessarily what the current code does. If a test fails, that is a real
// finding for the Defect Report — not a mistake in the test. This is called
// out explicitly in comments where it applies.

import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:campus_lost_found/backend/schema/items_record.dart';
import 'package:campus_lost_found/backend/schema/users_record.dart';

void main() {
  late FakeFirebaseFirestore firestore;

  setUp(() {
    firestore = FakeFirebaseFirestore();
  });

  group('ItemsRecord getters (covers TC-063, TC-064)', () {
    test('TC-063a: date getter returns null when the field is missing', () {
      final ref = firestore.collection('items').doc('item1');
      final data = <String, dynamic>{
        'itemId': 'item1',
        'title': 'Lost Wallet',
        // 'date' intentionally omitted
      };
      final record = ItemsRecord.getDocumentFromData(data, ref);
      expect(record.date, isNull);
    });

    test(
      'TC-063b [EXPECTED TO EXPOSE A DEFECT]: date getter should not throw '
      'when the field holds a malformed type (e.g. a String instead of a '
      'Timestamp/DateTime)',
      () {
        final ref = firestore.collection('items').doc('item2');
        final data = <String, dynamic>{
          'itemId': 'item2',
          'title': 'Lost Phone',
          'date': '2026-01-01', // malformed: String, not Timestamp/DateTime
        };
        // SRS NFR-Reliability requires the app "shall not crash on malformed
        // or missing Firestore fields." If this assertion fails with a
        // TypeError, that is a genuine defect to log, not a broken test.
        expect(
          () => ItemsRecord.getDocumentFromData(data, ref).date,
          returnsNormally,
        );
      },
    );

    test('TC-064: status getter defaults to empty string when field is absent', () {
      final ref = firestore.collection('items').doc('item3');
      final data = <String, dynamic>{'itemId': 'item3', 'title': 'Found Keys'};
      final record = ItemsRecord.getDocumentFromData(data, ref);
      expect(record.status, equals(''));
    });

    test('String fields default to empty string when entirely absent', () {
      final ref = firestore.collection('items').doc('item4');
      final record = ItemsRecord.getDocumentFromData(<String, dynamic>{}, ref);
      expect(record.title, equals(''));
      expect(record.category, equals(''));
      expect(record.description, equals(''));
      expect(record.location, equals(''));
      expect(record.contactInfo, equals(''));
      expect(record.postedBy, equals(''));
      expect(record.postedByName, equals(''));
      expect(record.type, equals(''));
      expect(record.itemId, equals(''));
      expect(record.date, isNull);
      expect(record.createdAt, isNull);
    });

    test('All fields populate correctly when fully and correctly provided', () {
      final ref = firestore.collection('items').doc('item5');
      final now = DateTime(2026, 6, 1);
      final data = <String, dynamic>{
        'itemId': 'item5',
        'title': 'Lost Umbrella',
        'type': 'lost',
        'category': 'accessories',
        'description': 'Black umbrella with wooden handle',
        'location': 'Library',
        'date': now,
        'postedBy': 'uid123',
        'postedByName': 'Ali',
        'contactInfo': '0300-0000000',
        'status': 'active',
        'createdAt': now,
      };
      final record = ItemsRecord.getDocumentFromData(data, ref);
      expect(record.title, 'Lost Umbrella');
      expect(record.type, 'lost');
      expect(record.status, 'active');
      expect(record.date, now);
      expect(record.createdAt, now);
    });
  });

  group('UsersRecord getters (covers TC-065)', () {
    test('TC-065: email getter returns null when the field is absent', () {
      final ref = firestore.collection('users').doc('user1');
      final record = UsersRecord.getDocumentFromData(<String, dynamic>{}, ref);
      expect(record.email, isNull);
    });

    test('All UsersRecord getters return null when fields are absent (no empty-string fallback)', () {
      final ref = firestore.collection('users').doc('user2');
      final record = UsersRecord.getDocumentFromData(<String, dynamic>{}, ref);
      expect(record.userID, isNull);
      expect(record.department, isNull);
      expect(record.name, isNull);
      expect(record.role, isNull);
      expect(record.displayName, isNull);
      expect(record.uid, isNull);
      expect(record.phoneNumber, isNull);
      expect(record.createdAt, isNull);
      expect(record.createdTime, isNull);
    });

    test('All UsersRecord fields populate correctly when fully provided', () {
      final ref = firestore.collection('users').doc('user3');
      final now = DateTime(2026, 1, 1);
      final data = <String, dynamic>{
        'UserID': 'u3',
        'department': 'Software Engineering',
        'name': 'Ayaz',
        'role': 'student',
        'displayName': 'Ayaz K.',
        'email': 'ayaz@example.edu',
        'uid': 'uid3',
        'phoneNumber': '0300-1112222',
        'createdAt': now,
        'createdTime': now,
      };
      final record = UsersRecord.getDocumentFromData(data, ref);
      expect(record.name, 'Ayaz');
      expect(record.email, 'ayaz@example.edu');
      expect(record.createdAt, now);
      expect(record.createdTime, now);
    });
  });

  group('Data-creation helpers (createItemsRecordData / createUsersRecordData)', () {
    test('createItemsRecordData omits null fields rather than storing them as null', () {
      final result = createItemsRecordData(title: 'Only Title');
      expect(result.containsKey('title'), isTrue);
      expect(result.containsKey('description'), isFalse);
    });

    test('createUsersRecordData omits null fields rather than storing them as null', () {
      final result = createUsersRecordData(name: 'Only Name');
      expect(result.containsKey('name'), isTrue);
      expect(result.containsKey('email'), isFalse);
    });

    test('createItemsRecordData converts a DateTime to a Firestore Timestamp', () {
      final now = DateTime(2026, 3, 15);
      final result = createItemsRecordData(title: 'X', date: now);
      // mapToFirestore() in firestore_util.dart should convert DateTime -> Timestamp
      expect(result['date'].runtimeType.toString(), contains('Timestamp'));
    });
  });
}