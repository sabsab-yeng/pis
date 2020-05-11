import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

    db.getAllCustomers().then((customer) {
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
          'Customers',
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
              height: 150,
              child: Column(
                children: <Widget>[
                  Divider(height: 5.0),
                  ListTile(
                    title: Row(
                      children: [
                        Text(
                          '${items[position].firstName}',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${items[position].lastName}',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${items[position].gender}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${items[position].phone}',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(FontAwesomeIcons.trash),
                              onPressed: () => _deleteCustomer(
                                  context, items[position], position),
                            ),
                          ],
                        ),
                      ],
                    ),
                    leading: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: CircleAvatar(
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
      db.getAllCustomers().then((customers) {
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
      db.getAllCustomers().then((customers) {
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
