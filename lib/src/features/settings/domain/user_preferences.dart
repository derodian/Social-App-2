import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:social_app_2/src/constants/firestore_field_name.dart';

part 'user_preferences.freezed.dart';
part 'user_preferences.g.dart';

enum AppThemeMode {
  system,
  light,
  dark;

  String get displayName => switch (this) {
        AppThemeMode.system => 'System',
        AppThemeMode.light => 'Light',
        AppThemeMode.dark => 'Dark',
      };
}

// Custom JSON converter for AppThemeMode enum
class AppThemeModeConverter implements JsonConverter<AppThemeMode, String> {
  const AppThemeModeConverter();

  @override
  AppThemeMode fromJson(String json) {
    return AppThemeMode.values.firstWhere(
      (e) => e.name == json,
      orElse: () => AppThemeMode.system,
    );
  }

  @override
  String toJson(AppThemeMode themeMode) => themeMode.name;
}

@freezed
class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    @JsonKey(name: FirestoreFieldName.themeMode)
    @AppThemeModeConverter()
    @Default(AppThemeMode.system)
    AppThemeMode themeMode,
    @JsonKey(name: FirestoreFieldName.language)
    @Default('en')
    String languageCode,
  }) = _UserPreferences;

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);

  static bool _isValidLanguageCode(String code) {
    // Add your supported language codes
    const supportedLanguages = ['en', 'es', 'fr'];
    return supportedLanguages.contains(code);
  }
}


// class UserPreferences {
//   final AppThemeMode themeMode;
//   final String languageCode;

//   const UserPreferences({
//     this.themeMode = AppThemeMode.system,
//     this.languageCode = 'en',
//   });

//   UserPreferences copyWith({
//     AppThemeMode? themeMode,
//     String? languageCode,
//   }) {
//     return UserPreferences(
//       themeMode: themeMode ?? this.themeMode,
//       languageCode: languageCode ?? this.languageCode,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'themeMode': themeMode.name, // Store enum as string
//       'languageCode': languageCode,
//     };
//   }

//   factory UserPreferences.fromMap(Map<String, dynamic> map) {
//     try {
//       final themeModeStr = map['themeMode'] as String;
//       final languageCode = map['languageCode'] as String;

//       // Validate theme mode
//       final themeMode = AppThemeMode.values.firstWhere(
//         (e) => e.name == themeModeStr,
//         orElse: () => AppThemeMode.system,
//       );

//       // Validate language code
//       if (!_isValidLanguageCode(languageCode)) {
//         throw FormatException('Invalid language code: $languageCode');
//       }

//       return UserPreferences(
//         themeMode: themeMode,
//         languageCode: languageCode,
//       );
//     } catch (e) {
//       // Return default preferences if parsing fails
//       debugPrint('Error parsing UserPreferences: $e');
//       return const UserPreferences();
//     }
//   }

//   static bool _isValidLanguageCode(String code) {
//     // Add your supported language codes
//     const supportedLanguages = ['en', 'es', 'fr'];
//     return supportedLanguages.contains(code);
//   }

//   String toJson() => json.encode(toMap());

//   factory UserPreferences.fromJson(String source) =>
//       UserPreferences.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() =>
//       'UserPreferences(themeMode: $themeMode, languageCode: $languageCode)';

//   @override
//   bool operator ==(covariant UserPreferences other) {
//     if (identical(this, other)) return true;

//     return other.themeMode == themeMode && other.languageCode == languageCode;
//   }

//   @override
//   int get hashCode => themeMode.hashCode ^ languageCode.hashCode;
// }

