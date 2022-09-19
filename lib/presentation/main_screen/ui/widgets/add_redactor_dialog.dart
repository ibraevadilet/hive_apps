import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_to_do/data/car_model.dart';
import 'package:hive_to_do/data/main_repo_impl.dart';
import 'package:hive_to_do/domain/main_use_case.dart';
import 'package:hive_to_do/presentation/main_screen/bloc/cubit/main_cubit.dart';
import 'package:hive_to_do/presentation/main_screen/ui/widgets/custom_text_field.dart';
import 'package:hive_to_do/presentation/main_screen/ui/widgets/enums.dart';

addRedactorDialog(
    {required BuildContext context,
    required String title,
    required Auto enums,
    CarModel? carModel}) async {
  final TextEditingController markaController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController engineController = TextEditingController();

  if (enums == Auto.redactor && carModel != null) {
    markaController.text = carModel.marka;
    modelController.text = carModel.model;
    yearController.text = carModel.year.toString();
    engineController.text = carModel.engine.toString();
  }

  return showDialog(
    context: context,
    builder: (context) => BlocProvider.value(
      value: MainCubit(MainUseCase(MainRepoImpl())),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        contentPadding: const EdgeInsets.all(15),
        insetPadding: const EdgeInsets.symmetric(horizontal: 12),
        content: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Builder(builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: 'Марка',
                  controller: markaController,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: 'Модель',
                  controller: modelController,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: 'Год выпуска',
                  controller: yearController,
                  textInputType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: 'Объем',
                  controller: engineController,
                  textInputType: TextInputType.number,
                ),
              ],
            );
          }),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          Builder(builder: (context) {
            return ElevatedButton(
              onPressed: () {
                if (enums == Auto.add) {
                  if (markaController.text != '') {
                    context.read<MainCubit>().addData(
                          CarModel(
                            marka: markaController.text,
                            model: modelController.text,
                            year: int.parse(yearController.text),
                            engine: double.parse(engineController.text),
                            id: int.parse(DateTime.now()
                                .microsecondsSinceEpoch
                                .toString()),
                          ),
                        );
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text(
                                'Вы не заполнили все поля',
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Ok'),
                                ),
                              ],
                            ));
                  }
                } else {
                  context.read<MainCubit>().editData(
                        CarModel(
                          marka: markaController.text,
                          model: modelController.text,
                          year: int.parse(yearController.text),
                          engine: double.parse(engineController.text),
                          id: carModel!.id,
                        ),
                      );
                }
                Navigator.pop(context);
              },
              child: Text(enums == Auto.add ? 'Добавить' : 'Сохранить'),
            );
          }),
        ],
      ),
    ),
  );
}
