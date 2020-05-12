import 'package:flutter/material.dart';
import 'package:pis/models/user.dart';

class AddUserDialog {
  final teName = TextEditingController();
  final teEmail = TextEditingController();
  final teAge = TextEditingController();
  final teMobile = TextEditingController();
  User user;

  static const TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  Widget buildAboutDialog(BuildContext context,
      AddUserCallback _myHomePageState, bool isEdit, User user) {
    if (user != null) {
      this.user = user;
      teName.text = user.name;
      teEmail.text = user.email;
      teAge.text = user.age;
      teMobile.text = user.mobile;
    }

    return AlertDialog(
      title: Text(isEdit ? 'Edit detail!' : 'Add new user!'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTextField("Name", teName),
            getTextField("Email", teEmail),
            getTextField("Age", teAge),
            getTextField("Mobile", teMobile),
           GestureDetector(
              onTap: () => onTap(isEdit, _myHomePageState, context),
              child: Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: getAppBorderButton(isEdit ? "Edit" : "Add",
                    EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTextField(
      String inputBoxName, TextEditingController inputBoxController) {
    var loginBtn = Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        controller: inputBoxController,
        decoration: InputDecoration(
          hintText: inputBoxName,
        ),
      ),
    );

    return loginBtn;
  }

  Widget getAppBorderButton(String buttonLabel, EdgeInsets margin) {
    var loginBtn = Container(
      margin: margin,
      padding: EdgeInsets.all(8.0),
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF28324E)),
        borderRadius: BorderRadius.all(const Radius.circular(6.0)),
      ),
      child: Text(
        buttonLabel,
        style: TextStyle(
          color: const Color(0xFF28324E),
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
    );
    return loginBtn;
  }

  User getData(bool isEdit) {
    return User(isEdit ? user.id : "", teName.text, teEmail.text,
        teAge.text, teMobile.text);
  }

  onTap(bool isEdit, AddUserCallback _myHomePageState, BuildContext context) {
    if (isEdit) {
      _myHomePageState.updateEmployee(getData(isEdit));
    } else {
      _myHomePageState.addEmployee(getData(isEdit));
    }

   Navigator.of(context).pop(); 

 }
}
//Call back of user dashboad
abstract class AddUserCallback {
  void addEmployee(User user);

  void updateEmployee(User user);
}