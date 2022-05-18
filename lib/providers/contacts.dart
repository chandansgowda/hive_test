import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Contacts extends ChangeNotifier{

  Future<List> get contacts async{
    Box contactsBox = await Hive.openBox('contact-box');
    return contactsBox.values.toList();
  }

}