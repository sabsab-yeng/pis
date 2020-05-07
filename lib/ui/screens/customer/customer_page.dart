import 'package:flutter/material.dart';
import 'package:pis/ui/screens/customer/cust_helper.dart';
import 'package:pis/ui/screens/customer/customer_model.dart';

import '../../ui_constant.dart';
import 'customer_input_page.dart';

class CustomerPage extends StatefulWidget {
  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  List<Customer> items = List();
  CustomerDatabaseHelper db = CustomerDatabaseHelper();

  @override
  void initState() {
    super.initState();

    db.getAllCustomer().then((customer) {
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
        title: Text(
          'All Customer',
          style: appbarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: appbarIconColor),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
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
                      style: TextStyle(
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
                            onPressed: () =>
                                _deleteCustomer(context, items[position], position),
                          ),
                        ),
                      ],
                    ),
                    onTap: () => _navigateToCustomer(context, items[position]),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _createNewCustomer(context),
      ),
    );
  }

  void _deleteCustomer(
      BuildContext context, Customer customer, int position) async {
    db.deleteCustomer(customer.id).then((result) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToCustomer(BuildContext context, Customer customer) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CustomerInfo(customer)),
    );

    if (result == 'update') {
      db.getAllCustomer().then((customers) {
        setState(() {
          items.clear();
          customers.forEach((customer) {
            items.add(Customer.fromMap(customer));
          });
        });
      });
    }
  }

  void _createNewCustomer(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CustomerInfo(Customer('', '', '', ''))),
    );

    if (result == 'save') {
      db.getAllCustomer().then((customers) {
        setState(() {
          items.clear();
          customers.forEach((customer) {
            items.add(Customer.fromMap(customer));
          });
        });
      });
    }
  }
}
