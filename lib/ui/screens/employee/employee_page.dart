// import 'package:flutter/material.dart';
// import 'package:pis/ui/widgets/raised_button_widget.dart';

// import '../../ui_constant.dart';
// class EmployeePage extends StatefulWidget {
//   @override
//   _EmployeePageState createState() => _EmployeePageState();
// }

// class _EmployeePageState extends State<EmployeePage> {
//   @override
//   Widget build(BuildContext context) {
//    return Scaffold(
//       appBar: AppBar(
//          elevation: 0,
//         iconTheme: IconThemeData(color: appbarIconColor),
//         title: Text(
//           'Employee',
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
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             children: [
//               Text(
//                 "Empployee information",
//                 style: appbarTextStyle,
//               ),
//               Flexible(
//                 flex: 0,
//                 child: Form(
//                   child: Flex(
//                     direction: Axis.vertical,
//                     children: [
//                       TextFormField(
//                        autofocus: true,
//                         decoration: InputDecoration(
//                           hintText: "First name",
//                           labelText: "First name",                        
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       TextFormField(
//                         autofocus: false,                           
//                         decoration: InputDecoration(
//                           hintText: "Last name",
//                           labelText: "Last name",
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       TextFormField(                                         
//                         autofocus: false,
//                         decoration: InputDecoration(
//                           hintText: "Gender",
//                           labelText: "Gender",
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       TextFormField(
//                       keyboardType: TextInputType.phone,                     
//                         autofocus: false,
//                         decoration: InputDecoration(
//                           hintText: "Phone number",
//                           labelText: "Phone number",
//                         ),
//                       ),
//                         TextFormField(                        
//                         autofocus: false,
//                         decoration: InputDecoration(
//                           hintText: "Job ID",
//                           labelText: "Job ID",
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       RaisedButtonWidget(title: "Insert",onPressed: (){},),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }