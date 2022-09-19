import 'package:hive_flutter/hive_flutter.dart';

part 'car_model.g.dart';

@HiveType(typeId: 0)
class CarModel extends HiveObject {
  @HiveField(0)
  String marka;

  @HiveField(1)
  String model;

  @HiveField(2)
  int year;

  @HiveField(3)
  double engine;

  @HiveField(4)
  int id;
  CarModel({
    required this.marka,
    required this.model,
    required this.year,
    required this.engine,
    required this.id,
  });

  @override
  String toString() {
    return '$marka, $model, $year, $engine';
  }
}
