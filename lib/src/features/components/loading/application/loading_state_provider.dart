import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'loading_state_provider.g.dart';

@riverpod
class LoadingState extends _$LoadingState {
  @override
  bool build() => false;

  void setLoading(bool isLoading) {
    state = isLoading;
  }
}
