import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_to_do/data/car_model.dart';
import 'package:hive_to_do/domain/main_repo.dart';

class MainRepoImpl implements MainRepo {
  @override
  getData() async {
    var box = await Hive.openBox<CarModel>('carBox');
    return box.values.toList();
  }

  @override
  addData(CarModel model) async {
    var box = await Hive.openBox<CarModel>('carBox');
    box.add(model);
  }

  @override
  deleteData(int id) async {
    var box = await Hive.openBox<CarModel>('carBox');
    final Map<dynamic, CarModel> deliveriesMap = box.toMap();
    dynamic desiredKey;
    deliveriesMap.forEach((key, value) {
      if (value.id == id) {
        desiredKey = key;
      }
    });
    box.delete(desiredKey);
    return box.values.toList();
  }

  @override
  editData(CarModel model) async {
    var box = await Hive.openBox<CarModel>('carBox');
    final Map<dynamic, CarModel> deliveriesMap = box.toMap();
    dynamic desiredKey;
    deliveriesMap.forEach((key, value) {
      if (value.id == model.id) {
        desiredKey = key;
      }
    });

    var car = box.get(desiredKey);
    log(car.toString());
    car?.marka = model.marka;
    car?.model = model.model;
    car?.year = model.year;
    car?.engine = model.engine;
    await car?.save();
  }
}
