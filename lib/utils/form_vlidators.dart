String? validateNonEmpty(String? value, String field) {
  if (value == null || value.trim().isEmpty) {
    return '$field is required';
  }
  return null;
}

String? validateAmount(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Amount is required';
  }
  final intVal = int.tryParse(value);
  if (intVal == null || intVal < 100) {
    return 'Amount must be at least 100 paise (₹1)';
  }
  return null;
}
