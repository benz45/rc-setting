bool isNotNullOrEmpty<T>(T? value) {
  if (value == null) return false;
  if (value is String) return value.isNotEmpty;
  if (value is List) return value.isNotEmpty;
  return true;
}

bool isNullOrEmpty<T>(T? value) {
  if (value == null) return true;
  if (value is String) return value.isEmpty;
  if (value is List) return value.isEmpty;
  return false;
}
