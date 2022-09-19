import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_to_do/data/car_model.dart';
import 'package:hive_to_do/domain/main_use_case.dart';

part 'main_state.dart';
part 'main_cubit.freezed.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(this.usecase) : super(const MainState.initial([]));
  final MainUseCase usecase;

  getData() async {
    emit(const MainState.loading());
    emit(MainState.initial(await usecase.getData()));
  }

  addData(CarModel model) async {
    await usecase.addData(model);
  }

  deleteData(int id) async {
    emit(const MainState.loading());
    emit(MainState.initial(await usecase.deleteData(id)));
  }

  editData(CarModel model) async {
    await usecase.editData(model);
  }
}
