import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/features/auth/presentation/widgets/address_widget.dart';

part 'distance_unit_preference.g.dart';

@riverpod
class DistanceUnitPreference extends _$DistanceUnitPreference {
  @override
  DistanceUnit build() {
    return DistanceUnit.both; // Default to showing both units
  }

  void setUnit(DistanceUnit unit) {
    state = unit;
  }
}
