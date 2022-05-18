import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/providers/contact.dart';
import 'package:hive_test/widgets/contact_item.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();

  List<Contact> _items = [];

  final _contactBox = Hive.box('contacts-box');

  void _refreshItems() {
    _items.clear();
    _contactBox.values.map((e) => _items.add(e));
  }

  void initState() {
    super.initState();
    _refreshItems();
  }

  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Contacts App'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) {
          final contact = _contactBox.values.toList()[i];
          return ContactItem(i,contact,_refreshItems);
        },
        itemCount: _contactBox.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Container(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _nameController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            label: Text("Name"),
                          ),
                        ),
                        TextField(
                          controller: _numberController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            label: Text("Mobile No."),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              _contactBox.add(Contact(
                                  DateTime.now().millisecondsSinceEpoch,
                                  _nameController.value.text,
                                  int.parse(_numberController.value.text)));
                              _nameController.clear();
                              _numberController.clear();
                              setState(() {
                                _refreshItems();
                              });
                              Navigator.of(context).pop();
                            },
                            child: Text("Add Contact"))
                      ],
                    ),
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
