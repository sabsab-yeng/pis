// import 'package:flutter/material.dart';
// import 'package:pis/ui/ui_constant.dart';
// import 'package:pis/ui/widgets/raised_button_widget.dart';

// class CustomerPage extends StatefulWidget {
//   @override
//   _CustomerPageState createState() => _CustomerPageState();
// }

// class _CustomerPageState extends State<CustomerPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         iconTheme: IconThemeData(color: appbarIconColor),
//         title: Text(
//           'Customer',
//           style: appbarTextStyle,
//         ),
//         backgroundColor: appBarColor,
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Center(
//         child: Container(
//           padding: EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: Colors.white,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(
//                   hintText: "Fist name",
//                   labelText: "First name",
//                 ),
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               TextFormField(
//                 decoration:
//                     InputDecoration(hintText: "Gender", labelText: "Gender"),
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               TextFormField(
//                 decoration: InputDecoration(
//                   hintText: "Telephone",
//                   labelText: "Telephone",
//                 ),
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               RaisedButtonWidget(
//                 title: "Insert",
//                 onPressed: () {},
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:pis/ui/screens/customer/cust_helper.dart';
import 'package:pis/ui/screens/customer/customer_model.dart';
 
class CustomerInfo extends StatefulWidget {
  final Customer customer;
  CustomerInfo(this.customer);
 
  @override
  State<StatefulWidget> createState() => new _CustomerInfoState();
}
 
class _CustomerInfoState extends State<CustomerInfo> {
  CustomerDatabaseHelper db = new CustomerDatabaseHelper();
 
  TextEditingController _firstNameController;
  TextEditingController _genderController;
  TextEditingController _phoneController;
 
  @override
  void initState() {
    super.initState();
 
    _firstNameController = new TextEditingController(text: widget.customer.firstName);
    _genderController = new TextEditingController(text: widget.customer.gender);
     _phoneController = new TextEditingController(text: widget.customer.phone);
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Customer')),
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
              controller: _genderController,
              decoration: InputDecoration(labelText: 'Gender'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.customer.id != null) ? Text('Update') : Text('Add'),
              onPressed: () {
                if (widget.customer.id != null) {
                  db.updateNote(Customer.fromMap({
                    'id': widget.customer.id,
                    'firstname': _firstNameController.text,
                    'gender': _genderController.text,
                    'phone': _phoneController.text,
                  })).then((_) {
                    Navigator.pop(context, 'update');
                  });
                }else {
                  db.saveNote(Customer(_firstNameController.text, _genderController.text, _phoneController.text)).then((_) {
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
