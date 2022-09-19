import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_to_do/data/main_repo_impl.dart';
import 'package:hive_to_do/domain/main_use_case.dart';
import 'package:hive_to_do/presentation/main_screen/bloc/cubit/main_cubit.dart';
import 'package:hive_to_do/presentation/main_screen/ui/widgets/add_redactor_dialog.dart';
import 'package:hive_to_do/presentation/main_screen/ui/widgets/card_widget.dart';
import 'package:hive_to_do/presentation/main_screen/ui/widgets/enums.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(MainUseCase(MainRepoImpl()))..getData(),
      child: Scaffold(
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () => addRedactorDialog(
                    context: context, title: 'Добавьте авто', enums: Auto.add)
                .then((velue) => context.read<MainCubit>().getData()),
            child: const Icon(Icons.add),
          ),
        ),
        appBar: AppBar(
          title: const Text('Список машин'),
          backgroundColor: Colors.blueAccent.shade400,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<MainCubit, MainState>(
            builder: (context, state) {
              return state.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  initial: (model) => model.isEmpty
                      ? const Center(
                          child: Text(
                            'У вас нет машин\nДобавьте машины',
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.builder(
                          itemCount: model.length,
                          itemBuilder: (context, index) =>
                              CardWidget(carModel: model[index])));
            },
          ),
        ),
      ),
    );
  }
}
