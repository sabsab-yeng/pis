import 'package:flutter/material.dart';
import 'package:pis/ui/screens/customer/cust_helper.dart';
import 'package:pis/ui/screens/customer/customer_model.dart';

import 'customer_input_page.dart';

class CustomerPage extends StatefulWidget {
  @override
  _CustomerPageState createState() => new _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  List<Customer> items = new List();
  CustomerDatabaseHelper db = new CustomerDatabaseHelper();

  @override
  void initState() {
    super.initState();

    db.getAllNotes().then((customer) {
      setState(() {
        customer.forEach((customer) {
          items.add(Customer.fromMap(customer));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ListView Customer'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Container(
                  height: 140,
                  child: Column(
                    children: <Widget>[
                      Divider(height: 5.0),
                      ListTile(
                        title: Text(
                          '${items[position].firstName}',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                        subtitle: Text(
                          '${items[position].gender}',
                          style: new TextStyle(
                            fontSize: 18.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        leading: Column(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.all(10.0)),
                            CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              radius: 15.0,
                              child: Text(
                                '${items[position].id}',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () => _deleteNote(
                                    context, items[position], position),
                              ),
                            ),
                          ],
                        ),
                        onTap: () => _navigateToNote(context, items[position]),
                      ),
                    ],
                  ),
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewNote(context),
        ),
    );
  }

  void _deleteNote(BuildContext context, Customer customer, int position) async {
    db.deleteNote(customer.id).then((notes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToNote(BuildContext context, Customer customer) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CustomerInfo(customer)),
    );

    if (result == 'update') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Customer.fromMap(note));
          });
        });
      });
    }
  }

  void _createNewNote(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CustomerInfo(Customer('', '','',''))),
    );

    if (result == 'save') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Customer.fromMap(note));
          });
        });
      });
    }
  }
}
