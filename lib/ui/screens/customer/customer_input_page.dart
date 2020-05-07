import 'package:flutter/material.dart';
import 'package:pis/ui/screens/customer/cust_helper.dart';
import 'package:pis/ui/screens/customer/customer_model.dart';

import '../../ui_constant.dart';

class CustomerInfo extends StatefulWidget {
  final Customer customer;
  CustomerInfo(this.customer);

  @override
  State<StatefulWidget> createState() => new _CustomerInfoState();
}

class _CustomerInfoState extends State<CustomerInfo> {
  CustomerDatabaseHelper db = new CustomerDatabaseHelper();

  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _genderController;
  TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();

    _firstNameController =
        new TextEditingController(text: widget.customer.firstName);
    _lastNameController =
        new TextEditingController(text: widget.customer.lastName);
    _genderController = new TextEditingController(text: widget.customer.gender);
    _phoneController = new TextEditingController(text: widget.customer.phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customer Info',
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
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _genderController,
              decoration: InputDecoration(labelText: 'Gender'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              child:
                  (widget.customer.id != null) ? Text('Update') : Text('Add'),
              onPressed: () {
                if (widget.customer.id != null) {
                  db
                      .updateNote(Customer.fromMap({
                    'id': widget.customer.id,
                    'firstname': _firstNameController.text,
                    'lastname': _lastNameController.text,
                    'gender': _genderController.text,
                    'phone': _phoneController.text,
                  }))
                      .then((_) {
                    Navigator.pop(context, 'update');
                  });
                } else {
                  db
                      .saveNote(
                    Customer(
                        _firstNameController.text,
                        _lastNameController.text,
                        _genderController.text,
                        _phoneController.text),
                  )
                      .then((_) {
                    Navigator.pop(context, 'save');
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
