extension MapJsonMergeExtension on Map<String, dynamic> {
  /// Merges non-null values from a JSON-convertible object into this map
  ///
  /// Takes an object that has a `toJson()` method and merges all its non-null
  /// values into the current map. Existing keys will be overwritten if the
  /// source object has non-null values for those keys.
  ///
  /// Example usage:
  /// ```dart
  /// final map = <String, dynamic>{};
  /// map.mergeFromJsonObject(autoWithdraw);
  /// ```
  /// or check the profile_screen_models.dart file the [ProfileDto]'s toJson()
  void mergeFromJsonObject(Map<String, dynamic>? object) {
    if (object == null) return;
    try {
      final json = object;
      json.forEach((key, value) {
        if (value != null) this[key] = value;
      });
    } catch (e) {
      // Handle or log error if toJson() is not available
      rethrow;
    }
  }

  /// Safe version that returns a new map instead of modifying the existing one
  ///
  /// Example usage:
  /// ```dart
  /// final newMap = map.mergedWithJsonObject(autoWithdraw);
  /// ```
  Map<String, dynamic> mergedWithJsonObject(Map<String, dynamic> object) {
    final newMap = Map<String, dynamic>.from(this);
    newMap.mergeFromJsonObject(object);
    return newMap;
  }
}
