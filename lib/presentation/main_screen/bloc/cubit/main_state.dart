part of 'main_cubit.dart';

@freezed
class MainState with _$MainState {
  const factory MainState.initial(List<CarModel> listModel) = _Initial;
  const factory MainState.loading() = _Loading;
}
