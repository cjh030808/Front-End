import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static bool _isInitialized = false;

  // Supabase Configuration
  static String get supabaseUrl => _getEnv('SUPABASE_URL');
  static String get supabaseAnonKey => _getEnv('SUPABASE_ANON_KEY');

  // Google Sign In Configuration
  static String get googleAndroidClientId => _getEnv('GOOGLE_ANDROID_CLIENT_ID');
  static String get googleWebClientId => _getEnv('GOOGLE_WEB_CLIENT_ID');

  // Initialize environment variables
  static Future<void> initialize() async {
    if (!_isInitialized) {
      await dotenv.load(fileName: '.env');
      _isInitialized = true;
    }
  }

  // Get environment variable with optional default value
  static String _getEnv(String key, {String? defaultValue}) {
    if (!_isInitialized) {
      throw Exception('EnvConfig not initialized. Call EnvConfig.initialize() first.');
    }

    final value = dotenv.env[key];
    if (value == null && defaultValue == null) {
      throw Exception('Environment variable $key not found and no default value provided.');
    }

    return value ?? defaultValue!;
  }

} 