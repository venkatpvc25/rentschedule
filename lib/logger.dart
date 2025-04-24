import 'package:logger/logger.dart';

class AppLogger {
  final String className;
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0, // hide method stack, since we add className
      printTime: true,
    ),
  );

  AppLogger(this.className);

  void d(dynamic message) => _logger.d("[$className] $message");
  void i(dynamic message) => _logger.i("[$className] $message");
  void w(dynamic message) => _logger.w("[$className] $message");
  void e(dynamic message) => _logger.e("[$className] $message");
  void v(dynamic message) => _logger.v("[$className] $message");
}
