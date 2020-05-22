
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pis/ui/screens/tools/material_choose_page.dart';
import 'package:pis/ui/widgets/google_map_widget.dart';
import 'package:pis/ui/widgets/raised_button_widget.dart';

import '../../ui_constant.dart';
import 'generate_survey_page.dart';

// class CheckLocationPage extends StatefulWidget {
//   @override
//   _CheckLocationPageState createState() => _CheckLocationPageState();
// }

// class _CheckLocationPageState extends State<CheckLocationPage> {
//   Completer<GoogleMapController> _controller = Completer();

//   static const LatLng _center = const LatLng(17.966793, 102.613271);

//   final Set<Marker> _markers = {};

//   LatLng _lastMapPosition = _center;

//   MapType _currentMapType = MapType.normal;

//   void _onMapTypeButtonPressed() {
//     setState(() {
//       _currentMapType = _currentMapType == MapType.normal
//           ? MapType.satellite
//           : MapType.normal;
//     });
//   }

//   static final CameraPosition _position1 = CameraPosition(
//     bearing: 192.833,
//     target: LatLng(18.9694, 102.6144),
//     tilt: 59.440,
//     zoom: 11.0,
//   );

//   Future<void> _gotoPosition1() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
//   }

//   void _onAddMarkerButtonPressed() {
//     setState(() {
//       _markers.add(Marker(
//         // This marker id can be anything that uniquely identifies each marker.
//         markerId: MarkerId(_lastMapPosition.toString()),
//         position: _lastMapPosition,
//         infoWindow: InfoWindow(
//           title: 'Really cool place',
//           snippet: '5 Star Rating',
//         ),
//         icon: BitmapDescriptor.defaultMarker,
//       ));
//     });
//   }

//   void _onCameraMove(CameraPosition position) {
//     _lastMapPosition = position.target;
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     _controller.complete(controller);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: appBarColor,
//         title: Text('Please tap your google map', ),
//          iconTheme: IconThemeData(color: appbarIconColor),
//       ),
//       body: Stack(
//         children: <Widget>[
//           GoogleMap(
//             // myLocationButtonEnabled: true,
//             // myLocationEnabled: true,
//             onMapCreated: _onMapCreated,
//             initialCameraPosition: CameraPosition(
//               target: _center,
//               zoom: 11.0,
//             ),
//             mapType: _currentMapType,
//             markers: _markers,
//             onCameraMove: _onCameraMove,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Align(
//               alignment: Alignment.topRight,
//               child: Column(
//                 children: <Widget>[
//                   FloatingActionButton(
//                     heroTag: "btn1",
//                     onPressed: _onMapTypeButtonPressed,
//                     materialTapTargetSize: MaterialTapTargetSize.padded,
//                     backgroundColor: Colors.blue,
//                     child: const Icon(Icons.map, size: 36.0),
//                   ),
//                   SizedBox(height: 16.0),
//                   FloatingActionButton(
//                     heroTag: "btn2",
//                     onPressed: _onAddMarkerButtonPressed,
//                     materialTapTargetSize: MaterialTapTargetSize.padded,
//                     backgroundColor: Colors.blue,
//                     child: const Icon(Icons.add_location, size: 36.0),
//                   ),
//                   SizedBox(height: 16.0),
//                   FloatingActionButton(
//                     heroTag: "btn3",
//                     onPressed: _gotoPosition1,
//                     materialTapTargetSize: MaterialTapTargetSize.padded,
//                     backgroundColor: Colors.blue,
//                     child: const Icon(Icons.location_searching, size: 36.0),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomSheet: RaisedButtonWidget(title: "Generate", onPressed: (){
//         Navigator.push(context, MaterialPageRoute(builder: (context)=> GenerateSurveyPage()));
//       },),
//     );
//   }
// }

class CheckLocationPage extends StatefulWidget {
  @override
  _CheckLocationPageState createState() => _CheckLocationPageState();
}

class _CheckLocationPageState extends State<CheckLocationPage> {
  @override
  Widget build(BuildContext context) {
   return  Stack(fit: StackFit.expand, children: <Widget>[
        FullMapWidget(onSelectedLocation: (lat, long) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> MaterialChoosePage()));
          // Create the member now and set the category
          // onboardingBloc.setUserLocation(lat, long);
          // Push to next screen
          // Navigator.of(context).push(
          //   PageRouteBuilder(
          //       transitionDuration: Duration(milliseconds: 600),
          //       pageBuilder: (_, __, ___) {
          //         return CustomerOnBoardingProvider(
          //           child: CustomerOnBoardingStepTwo(
          //             onboardingBloc: onboardingBloc,
          //             heroWidget: widget.heroWidget,
          //           ),
          //         );
          //       }),
          // );
        }),
        // Align(
        //   child: Padding(
        //     padding: const EdgeInsets.all(20),
        //     child: widget.heroWidget,
        //   ),
        //   alignment: Alignment.topLeft,
        // )
      ],
   );
  }
}
