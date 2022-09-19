import 'package:hive_to_do/data/car_model.dart';
import 'package:hive_to_do/domain/main_repo.dart';

class MainUseCase {
  MainUseCase(this.repo);
  final MainRepo repo;

  getData() async {
    return await repo.getData();
  }

  addData(CarModel model)  async {
     await repo.addData(model);
  }

  deleteData(int id) async {
    return await repo.deleteData(id);
  }

  editData(CarModel model) async {
     repo.editData(model);
  }
}
