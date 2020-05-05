import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pis/ui/widgets/stack_button_widget.dart';
import '../ui_constant.dart';

class FullMapWidget extends StatefulWidget {
  final Function onSelectedLocation;
  final Position defaultPosition;
  FullMapWidget({this.onSelectedLocation, this.defaultPosition});

  @override
  _FullMapWidgetState createState() => _FullMapWidgetState();
}

class _FullMapWidgetState extends State<FullMapWidget> {
  // Default location would be vientiane
  final Position _defaultPosition =
      Position(latitude: 17.966793, longitude: 102.613271);
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController _googleMapController;
  Future<Position> _currentLocation;
  Set<Marker> _markers = Set();
  LatLng _selectedCoordinate;
  String _selectedPlacemark;

  void _getCurrentLocation() async {
    try {
      _currentLocation = Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {});
    } on Exception {
      _currentLocation = Future.value(_defaultPosition);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    // If there's no preset user location, we will offer to get current user location
    if (widget.defaultPosition != null) {
      _currentLocation = Future.value(widget.defaultPosition);
      _addMarker(LatLng(
          widget.defaultPosition.latitude, widget.defaultPosition.longitude));
    } else {
      _getCurrentLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0.0,
        title: Text('Choose area',
        style: appbarTextStyle,
        ),
        centerTitle: true,
       iconTheme: IconThemeData(color: appbarIconColor),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: FutureBuilder(
                      future: _currentLocation,
                      builder: (context, snapshot) {
                        if (snapshot.hasData == false &&
                            snapshot.hasError == false) {
                          return Center(child: CircularProgressIndicator());
                        }

                        Position currentLocation = snapshot.data;
                        if (snapshot.hasError == true) {
                          currentLocation = _defaultPosition;
                        }

                        print(
                            "***** current Your Location ***** (${currentLocation.latitude},${currentLocation.longitude})");
                        return GoogleMap(
                          gestureRecognizers: Set()
                            ..add(Factory<PanGestureRecognizer>(
                                () => PanGestureRecognizer()))
                            ..add(Factory<ScaleGestureRecognizer>(
                                () => ScaleGestureRecognizer())),
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          mapType: MapType.normal,
                          markers: _markers,
                          initialCameraPosition: CameraPosition(
                              target: (widget.defaultPosition != null)
                                  ? LatLng(widget.defaultPosition.latitude,
                                      widget.defaultPosition.longitude)
                                  : LatLng(currentLocation.latitude,
                                      currentLocation.longitude),
                              zoom: (snapshot.hasError == true) ? 14 : 17),
                          onMapCreated: (GoogleMapController controller) {
                            _googleMapController = controller;
                            _controller.complete(_googleMapController);
                          },
                          onTap: (latLong) {
                            print("GoogleMap Click : $latLong");
                            _addMarker(latLong);
                          },
                        );
                      },
                    ),
                  ),
                ), // Next button
                SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: StackButtonWiget(
                    onPressed: () {
                      if (widget.onSelectedLocation != null &&
                          _selectedCoordinate != null) {
                        widget.onSelectedLocation(_selectedCoordinate.latitude,
                            _selectedCoordinate.longitude);
                      }
                    },
                    titleText: (_selectedCoordinate == null)
                        ? "On tap"
                        : " Is my location",
                    subtitleText: _selectedPlacemark,
                    mainColor: (_selectedCoordinate != null)
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _addMarker(LatLng latLong) async {
    // googleMapController.
    Marker _marker = new Marker(
      icon: BitmapDescriptor.defaultMarker,
      markerId: MarkerId("CustomerLocation"),
      position: latLong,
    );

    Geolocator()
        .placemarkFromCoordinates(latLong.latitude, latLong.longitude)
        .then((result) {
      _markers = null;
      _markers = Set();
      _markers.add(_marker);
      result.forEach((res) {
        print("> ${res.name}");
      });
      setState(() {
        _selectedCoordinate = latLong;
        List<String> name = [
          result.first.name,
          result.first.subLocality,
          result.first.subAdministrativeArea,
          result.first.administrativeArea
        ];
        name.removeWhere((i) => i.isEmpty);
        _selectedPlacemark = name.join(", ");
      });
    });
  }
}
