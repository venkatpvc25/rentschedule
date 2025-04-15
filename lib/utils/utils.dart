// email vlaidation function
bool isValidEmail(String email) {
  const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  final regex = RegExp(pattern);
  return regex.hasMatch(email);
}

// password validation function
bool isValidPassword(String password) {
  const pattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
  final regex = RegExp(pattern);
  return regex.hasMatch(password);
}

// phone number validation function
bool isValidPhoneNumber(String phoneNumber) {
  const pattern = r'^\+?[0-9]{10,15}$';
  final regex = RegExp(pattern);
  return regex.hasMatch(phoneNumber);
}

/// Validates an amount.
/// Amount must be a positive number greater than zero.
bool isValidAmount(String amount) {
  final amountRegex = RegExp(r'^[1-9]\d*(\.\d+)?$');
  return amountRegex.hasMatch(amount);
}
