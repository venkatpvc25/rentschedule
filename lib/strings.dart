class AppStrings {
  // General
  static const String appTitle = "Rent Schedule";

  // Subscription Screen
  static const String subscriptionTitle = "Rent Subscription";
  static const String emailLabel = "Email";
  static const String emailRequired = "Email is required";
  static const String emailInvalid = "Enter a valid email";
  static const String contactLabel = "Contact";
  static const String contactRequired = "Contact number is required";
  static const String contactInvalid = "Enter a valid Indian phone number";
  static const String amountLabel = "Amount (INR)";
  static const String amountRequired = "Amount is required";
  static const String amountInvalid = "Enter a valid amount";
  static const String startSubscription = "Start Subscription";
  static const String subscriptionSuccess =
      "Subscription created successfully!";
  static const String subscriptionError =
      "Failed to create subscription. Please try again.";
  static const String loading = "Loading...";
  static const String noInternet =
      "No internet connection. Please check your settings.";

  // Dio Service Error Messages
  static const String connectionTimeout =
      'Connection timed out. Please try again.';
  static const String badRequest = 'Bad request. Please check your input.';
  static const String unauthorized = 'Unauthorized. Please log in again.';
  static const String serverError = 'Server error. Please try again later.';
  static const String unknownError =
      'No internet connection. Please check your network.';
  static const String unexpectedError = 'Unexpected error occurred.';
  static const String genericError = 'Something went wrong. Please try again.';
}
