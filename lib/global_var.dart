import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class GlobalVariables {
  static final GlobalVariables _instance = GlobalVariables._internal();

  factory GlobalVariables() => _instance;

  GlobalVariables._internal();
  late MapController mapController;

  int bloco = 0;
  int andar = 0;

  Position? posicao;

  List<LatLng> finalLoc = [];
}