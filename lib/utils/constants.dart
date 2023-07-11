import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

class Constance {
  late String apiKey;
  late String secretKey;
  late String apiEndpoint;

  static Constance instance = Constance._internal();

  Constance._internal() {
    apiKey = dotenv.env['API_KEY'] ?? '';
    secretKey = dotenv.env['SECRET_KEY'] ?? '';
    apiEndpoint = dotenv.env['API_ENDPOINT'] ?? '';
  }

  final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  static void init() {
    instance = Constance._internal();
  }

  static Logger get theLogger => instance.logger;
  static String get theID => const Uuid().v4();
  static String get theApiKey => instance.apiKey;
  static String get theSecretKey => instance.secretKey;
  static String get theApiEndpoint => instance.apiEndpoint;
}
