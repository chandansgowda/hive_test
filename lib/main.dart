import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/contact.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ContactAdapter());
  await Hive.openBox("contacts_box");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Contact> _items = [];

  final _contactBox = Hive.box('contacts_box');

  void _refreshItems(){
    _contactBox.values.map((e) => _items.add(e));
  }

  void initState(){
    super.initState();
    _refreshItems();
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _refreshItems();
    return Scaffold(
      body: ListView(
        children: _items.map((e) {
          return Card(
            child: ListTile(
              title: Text(e.name),
              subtitle: Text(e.number.toString()),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(context: context, builder: (_){
            return Container(
              padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      label: Text("Name"),
                    ),
                  ),
                  TextField(
                    controller: _numberController,
                    decoration: InputDecoration(
                      label: Text("Mobile No."),
                    ),
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(onPressed: (){
                    _contactBox.add(Contact(DateTime.now().millisecondsSinceEpoch, _nameController.value.text, int.parse(_numberController.value.text)));
                    _nameController.clear();
                    _numberController.clear();
                  }, child: Text("Add Contact"))
                ],
              ),
            );
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
