import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_to_do/data/car_model.dart';
import 'package:hive_to_do/presentation/main_screen/bloc/cubit/main_cubit.dart';
import 'package:hive_to_do/presentation/main_screen/ui/widgets/add_redactor_dialog.dart';
import 'package:hive_to_do/presentation/main_screen/ui/widgets/column_widget.dart';
import 'package:hive_to_do/presentation/main_screen/ui/widgets/enums.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({required this.carModel, Key? key}) : super(key: key);
  final CarModel carModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => addRedactorDialog(
              context: context,
              title: 'Редактирвать авто',
              enums: Auto.redactor,
              carModel: carModel).then((velue) => context.read<MainCubit>().getData()),
          child: Dismissible(
            direction: DismissDirection.endToStart,
            key: UniqueKey(),
            onDismissed: (DismissDirection direction) {
              context.read<MainCubit>().deleteData(carModel.id);
            },
            background: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: const Text(
                'Удалить',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.blueAccent.shade400,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ColumnWidget('Марка:', carModel.marka),
                  ColumnWidget('Модель:', carModel.model),
                  ColumnWidget('Год выпуск:', carModel.year.toString()),
                  ColumnWidget('Объем:', carModel.engine.toString()),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
