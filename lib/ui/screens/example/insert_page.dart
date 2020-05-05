import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pis/models/student.dart';
import 'package:pis/ui/ui_constant.dart';

class InsertPage extends StatefulWidget {
  @override
  _InsertPageState createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {
  final FirebaseDatabase database = FirebaseDatabase.instance;

  List<Student> listStudent = List();
  Student student;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference databaseReference;

  @override
  void initState() {
    super.initState();
    student = Student();

    databaseReference = database.reference().child("tb_Student");
    databaseReference.onChildAdded.listen(_onAdd);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "insert Example",
          style: appbarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: appbarIconColor),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "Insert Data below",
                style: appbarTextStyle,
              ),
              Flexible(
                flex: 0,
                child: Form(
                  key: formKey,
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: "First name",
                          labelText: "First name",
                        ),
                        onSaved: (val) => student.fname = val,
                        validator: (val) => val == "" ? val : null,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autofocus: false,
                        onSaved: (val) => student.lname = val,
                        validator: (val) => val == "" ? val : null,
                        decoration: InputDecoration(
                          hintText: "Last name",
                          labelText: "Last name",
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onSaved: (val) => student.age = val,
                        validator: (val) => val == "" ? val : null,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: "Age",
                          labelText: "Age",
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        child: Text('Insert'),
                        onPressed: () {
                          postStudent();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onAdd(Event event) {
    setState(() {
      listStudent.add(Student.fromSnapshot(event.snapshot));
    });
  }

  void postStudent() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();

      //Save data to firebase
      databaseReference.push().set(student.toJson());
    }
  }
}


// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// class BasicFirebasePage extends StatefulWidget {

//   @override
//   _BasicFirebasePageState createState() => _BasicFirebasePageState();
// }

// class _BasicFirebasePageState extends State<BasicFirebasePage> {

//   final FirebaseDatabase database = FirebaseDatabase.instance;

//   void _incrementCounter() {
//     database.reference().child("yeng_tb").set({
//       "First name" : "Sabsab Flutter Development Loas",
//       "Last naem" : "My God",
//       "age" : 23
//     });
//     setState(() {
//       database.reference().child("sfDB").once().then((DataSnapshot snapshot) {
//         Map<dynamic, dynamic> data = snapshot.value;
//         print("Value: ${snapshot.value}");
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Basic Page"),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
