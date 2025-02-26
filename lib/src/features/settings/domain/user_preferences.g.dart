// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserPreferencesImpl _$$UserPreferencesImplFromJson(
        Map<String, dynamic> json) =>
    _$UserPreferencesImpl(
      themeMode: json['theme_mode'] == null
          ? AppThemeMode.system
          : const AppThemeModeConverter()
              .fromJson(json['theme_mode'] as String),
      languageCode: json['language'] as String? ?? 'en',
    );

Map<String, dynamic> _$$UserPreferencesImplToJson(
        _$UserPreferencesImpl instance) =>
    <String, dynamic>{
      'theme_mode': const AppThemeModeConverter().toJson(instance.themeMode),
      'language': instance.languageCode,
    };
