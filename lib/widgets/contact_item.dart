import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/providers/contact.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;
  final int index;
  final Function refreshFunc;

  ContactItem(this.index,this.contact, this.refreshFunc);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(child: Text('${index+1}'), ),
          title: Text(contact.name),
          subtitle: Text(contact.number.toString()),
          trailing: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text("Are you sure ?"),
                        content: Text(
                          "This contact cannot be restored!",
                          style: TextStyle(fontSize: 13),
                        ),
                        actionsAlignment: MainAxisAlignment.spaceAround,
                        actions: [
                          SimpleDialogOption(
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            onPressed: () {
                              Hive.box("contacts-box").deleteAt(index);
                              refreshFunc;
                              Navigator.of(context).pop();
                            },
                          ),
                          SimpleDialogOption(
                            child: Text("No"),
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });

              },
              icon: Icon(Icons.delete)),
        ),
      ),
    );
  }
}
