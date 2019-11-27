import 'dart:async';
import 'package:app_passageiro/src/ui/widgets/ride_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:app_passageiro/src/util/map_util.dart';
import 'package:app_passageiro/src/ui/widgets/home_menu_drawer.dart';
import 'package:app_passageiro/src/ui/widgets/functionalButton.dart';
import 'package:app_passageiro/src/model/place.item.res.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  Completer<GoogleMapController> _completer = Completer();
  GoogleMapController _controller;
  MapUtil mapUtil = MapUtil();
  Location _locationService = Location();
  LatLng currentLocation;
  LatLng _center = LatLng(-10.9472, -37.0731);
  bool _permission = false;
  List<Marker> _allMarkers = List();
  List<Polyline> routes = new List();
  bool done = false;
  String error;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    // _allMarkers.add(Marker(
    //   markerId: MarkerId("Unit"),
    //   draggable: false,
    //   onTap: (){
    //     print("Marker clicado!");
    //     moveTo(-10.9698,  -37.0587);
    //   },
    //   position: LatLng(-10.9698,  -37.0587),
    //   infoWindow: InfoWindow(title: "Universidade Tiradentes")
    // ));
    // _allMarkers.add(Marker(
    //   markerId: MarkerId("Trabalho"),
    //   draggable: false,
    //   onTap: (){
    //     print("Marker clicado!");
    //     moveTo(-10.9484874, -37.06487775);
    //   },
    //   position: LatLng(-10.9484874, -37.06487775),
    //   infoWindow: InfoWindow(title: "Atos Capital")
    // ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      bottomSheet: Container(
        height: 300,
        decoration: BoxDecoration(color: Colors.black),
        child: Column(),
      ),
      drawer: Drawer(
        child: HomeMenuDrawer(),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 13.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              _completer.complete(controller);
              mapCreated(controller);
            },
            markers: Set<Marker>.of(_allMarkers),
            polylines: Set<Polyline>.of(routes),
          ),
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: Column(
              children: <Widget>[
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  leading: FlatButton(
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                    child: Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: RidePicker(onPlaceSelected),
                )
              ],
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FunctionalButton(
                    icon: Icons.work,
                    title: "Trabalho",
                    onPressed: () => moveTo(-10.9484874, -37.06487775)
                  ),
                  FunctionalButton(
                    icon: Icons.home,
                    title: "Casa",
                    onPressed: () => moveTo(-11.272281, -37.439685),                   
                  ),
                  FunctionalButton(
                    icon: Icons.school,
                    title: "Universidade",
                    onPressed: () => moveTo(-10.9698, -37.0587),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void mapCreated(controller){
    setState(() {
      _controller = controller;
    });
  }

  moveTo(double latitude, double longitude){
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(latitude, longitude), zoom: 17.0, bearing: 45.0, tilt: 45.0)
    ));
  }

  void onPlaceSelected(PlaceItemRes place, bool fromAddress) {
    var mkId = fromAddress ? "from_address" : "to_address";
    _addMarker(mkId, place);
    addPolyline();
  }

  void _addMarker(String mkId, PlaceItemRes place) async {
    // remove old
    _allMarkers.remove(mkId);
    //_mapController.clearMarkers();

    Marker marker = Marker(
      markerId: MarkerId(mkId),
      draggable: true,
      position: LatLng(place.lat, place.lng),
      infoWindow: InfoWindow(title: mkId),
    );

    setState(() {
      if (mkId == "from_address") {
        _allMarkers[0] = (marker);
        List mmmm = _allMarkers;
        print(mmmm); 
      } else if (mkId == "to_address") {
        _allMarkers.add(marker);  
        List mmmm = _allMarkers;
        print(mmmm);      
      }
    });
  }

  getCurrentLocation() async {
    currentLocation = await mapUtil.getCurrentLocation();
    _center = LatLng(currentLocation.latitude, currentLocation.longitude);
    Marker marker = Marker(
      markerId: MarkerId('location'),
      position: _center,
      infoWindow: InfoWindow(title: 'My Location'),
    );
    setState(() {
      _allMarkers.add(marker);
    });
  }

  addPolyline() async {
      //routes.clear();
      if (_allMarkers.length > 1) {
        mapUtil
            .getRoutePath(
                LatLng(_allMarkers[0].position.latitude,
                    _allMarkers[0].position.longitude),
                LatLng(_allMarkers[1].position.latitude,
                    _allMarkers[1].position.longitude))
            .then((locations) {
          List<LatLng> path = new List();

          locations.forEach((location) {
            path.add(new LatLng(location.latitude, location.longitude));
          });

          final Polyline polyline = Polyline(
            polylineId: PolylineId(_allMarkers[1].position.latitude.toString() +
                _allMarkers[1].position.longitude.toString()),
            consumeTapEvents: true,
            color: Colors.black,
            width: 2,
            points: path,
          );

          setState(() {
            routes.add(polyline);
          });
        });
      }
  }

  initPlatformState() async {
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.HIGH, interval: 1000);

    LocationData location;
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {
          location = await _locationService.getLocation();
          Marker marker = Marker(
            markerId: MarkerId('from_address'),
            position: LatLng(location.latitude, location.longitude),
            infoWindow: InfoWindow(title: 'Minha localização'),
          );
          if (mounted) {
            setState(() {
              currentLocation = LatLng(location.latitude, location.longitude);
              _center =
                  LatLng(currentLocation.latitude, currentLocation.longitude);
              _allMarkers.add(marker);
              done = true;
            });
          }
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if (serviceStatusResult) {
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      //location = null;
    }
  }
}
