import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(methodCount: 2),
);

var log = Logger(
  printer: PrettyPrinter(methodCount: 0),
);


