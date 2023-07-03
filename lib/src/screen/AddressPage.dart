import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPage createState() => _AddressPage();
}

class _AddressPage extends State<AddressPage> {
  String googleApikey = "AIzaSyAAyHoCJwzvjHgQCmJAMeRNQk1hiWyyM0A";
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: "AIzaSyAAyHoCJwzvjHgQCmJAMeRNQk1hiWyyM0A");
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(26.9669912, 75.7268816);
  String location = "Location Name:";
  @override
  void initState() {
    checkGps();
    super.initState();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();

    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    late StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {
        //refresh UI on update
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Get GPS Location"), backgroundColor: Colors.redAccent),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () async {
                    // show input autocomplete with selected mode
                    // then get the Prediction selected
                    Prediction p = await PlacesAutocomplete.show(
                        context: context, apiKey: kGoogleApiKey);
                    displayPrediction(p);
                  },
                  child: Text('Find address'),
                ))));
    /* Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(50),
            child: Column(
              children: [
                SearchMapPlaceWidget(
                    apiKey: googleApikey,
                    // The language of the autocompletion
                    language: 'en',
                    // The position used to give better recomendations. In this case we are using the user position
                    location: LatLng(double.parse(lat), double.parse(long)),
                    radius: 30000,
                    onSelected: (Place place) async {
                      final geolocation = await place.geolocation;
                      print("************************************");
                      print(geolocation);
                    }), */
    /*  Text(servicestatus ? "GPS is Enabled" : "GPS is disabled."),
            Text(haspermission ? "GPS is Enabled" : "GPS is disabled."),
            Text("Longitude: $long", style: TextStyle(fontSize: 20)),
            Text(
              "Latitude: $lat",
              style: TextStyle(fontSize: 20),
            ), */
    /*  Column(children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .5,
                        child: Stack(children: [
                          GoogleMap(
                            //Map widget from google_maps_flutter package
                            zoomGesturesEnabled:
                                true, //enable Zoom in, out on map
                            initialCameraPosition: CameraPosition(
                              //innital position in map
                              target: startLocation, //initial position
                              zoom: 14.0, //initial zoom level
                            ),
                            mapType: MapType.normal, //map type
                            onMapCreated: (controller) {
                              //method called when map is created
                              setState(() {
                                mapController = controller;
                              });
                            },
                            onCameraMove: (CameraPosition cameraPositiona) {
                              cameraPosition = cameraPositiona;
                            },
                            onCameraIdle: () async {
                              List<Placemark> placemarks =
                                  await placemarkFromCoordinates(
                                      cameraPosition!.target.latitude,
                                      cameraPosition!.target.longitude);
                              setState(() {
                                location = placemarks.first.administrativeArea
                                        .toString() +
                                    ", " +
                                    placemarks.first.street.toString();
                              });
                            },
                          ),

                          //search autoconplete input
                          Positioned(
                              //search input bar
                              top: 10,
                              child: InkWell(
                                  onTap: () async {
                                    var place = await PlacesAutocomplete.show(
                                        context: context,
                                        apiKey: googleApikey,
                                        mode: Mode.overlay,
                                        types: [],
                                        strictbounds: false,
                                        components: [
                                          Component(Component.country, 'in')
                                        ],
                                        //google_map_webservice package
                                        onError: (err) {
                                          print(err);
                                        });

                                    if (place != null) {
                                      print("##############################");
                                      print(place);
                                      setState(() {
                                        location = place.description.toString();
                                      });
                                      //form google_maps_webservice package
                                      final plist = GoogleMapsPlaces(
                                        apiKey: googleApikey,
                                        apiHeaders: await GoogleApiHeaders()
                                            .getHeaders(),
                                        //from google_api_headers package
                                      );
                                      String placeid = place.placeId ?? "0";
                                      final detail = await plist
                                          .getDetailsByPlaceId(placeid);
                                      final geometry = detail.result.geometry!;
                                      final lat = geometry.location.lat;
                                      final lang = geometry.location.lng;
                                      var newlatlang = LatLng(lat, lang);

                                      //move map camera to selected place with animation
                                      mapController?.animateCamera(
                                          CameraUpdate.newCameraPosition(
                                              CameraPosition(
                                                  target: newlatlang,
                                                  zoom: 17)));
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Card(
                                      child: Container(
                                          padding: EdgeInsets.all(0),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              40,
                                          child: ListTile(
                                            leading: Image.asset(
                                              "assets/images/icons/card.png",
                                              width: 25,
                                            ),
                                            title: Text(
                                              location,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            trailing: Icon(Icons.search),
                                            dense: true,
                                          )),
                                    ),
                                  )))
                        ])),
                  )
                ]) */
    /*    ],
            ),
          ),
        )); */


        
  }
  
  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);

      print(lat);
      print(lng);
    }
}
