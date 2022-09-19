import 'package:hive_to_do/data/car_model.dart';

abstract class MainRepo {
  getData();
  addData(CarModel model);
  deleteData(int id);
  editData(CarModel model);
}
