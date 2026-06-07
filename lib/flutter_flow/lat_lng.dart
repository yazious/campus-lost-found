class LatLng {
  const LatLng(this.latitude, this.longitude);

  final double latitude;
  final double longitude;

  String serialize() => '$latitude,$longitude';

  static LatLng? deserialize(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    final parts = value.split(',');
    if (parts.length != 2) {
      return null;
    }
    return LatLng(double.parse(parts[0]), double.parse(parts[1]));
  }

  @override
  String toString() => 'LatLng(lat: $latitude, lng: $longitude)';
}
