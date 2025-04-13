/// Configuration class to access environment variables
/// defined in the --dart-define-from-file JSON configuration
class EnvConfig {
  /// iOS App Store URL for the application
  static String get iosAppStoreUrl =>
      const String.fromEnvironment('IOS_APPSTORE_URL');

  /// Google Play Store URL for the application
  static String get androidGooglePlayUrl =>
      const String.fromEnvironment('ANDROID_GOOGLEPLAY_URL');

  /// Support email address for the application
  static String get email => const String.fromEnvironment('EMAIL');
}
