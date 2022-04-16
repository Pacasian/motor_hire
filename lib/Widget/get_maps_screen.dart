import 'package:flutter/material.dart';
import 'dart:html';
import 'dart:ui' as ui;

import 'package:google_maps/google_maps.dart';
Widget getMap(String latLang) {
  String htmlId = "7";
List latlong=latLang.split(",");
  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
    final myLatlng = LatLng(1.3521, 103.8198);

    final mapOptions = MapOptions()
      ..zoom = 10
      ..center = LatLng(double.parse(latlong[0]), double.parse(latlong[1]));

    final elem = DivElement()
      ..id = htmlId
      ..style.width = "100%"
      ..style.height = "100%"
      ..style.border = 'none';

    final map = GMap(elem, mapOptions);

    Marker(MarkerOptions()
      ..position = myLatlng
      ..map = map
      ..title = 'Hello World!'
    );

    return elem;
  });

  return HtmlElementView(viewType: htmlId);
}