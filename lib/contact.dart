import 'package:hive_flutter/hive_flutter.dart';

part 'contact.g.dart';

@HiveType(typeId: 0)
class Contact extends HiveObject{
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int number;

  Contact(this.id, this.name, this.number);
}