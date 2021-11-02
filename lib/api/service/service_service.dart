import 'dart:convert';

import 'package:smpark/api/service_api.dart';
import 'package:smpark/src/providers/GeoSearch.dart';
import 'package:smpark/src/providers/list_provider.dart';

abstract class ServiceService {
  Future<ObjectParkWrapper> findServiceByFilter(
      double? latitud, double? longitude);
  Future<GeoSearch> findCordsByDesc(
      String desc, double latitud, double longitude);
}

class ServiceServiceImpl implements ServiceService {
  final ServiceAPI _api;
  const ServiceServiceImpl(this._api);

  @override
  Future<ObjectParkWrapper> findServiceByFilter(
          double? latitud, double? longitude) =>
      //Future.value(ObjectParkWrapper.fromJson(jsonDecode(DUMMY_RESPONSE)));
      _api.consumeGet(
          ServiceConstants.SERVICE_BY_COLLAB_PATH + "$latitud/$longitude");

  @override
  Future<GeoSearch> findCordsByDesc(
          String desc, double latitud, double longitude) =>
      //Future.value(ObjectParkWrapper.fromJson(jsonDecode(DUMMY_RESPONSE)));

      _api.consumeGetPure(
          "maps.googleapis.com", "maps/api/place/autocomplete/json", {
        "input": "$desc",
        "location": "$latitud,$longitude",
        "radius": "10000",
        "types": "address",
        "key": "AIzaSyDV_ORZYJ_7h94Jc2dDLRK7lAKaWqvGzIs"
      });
}

String DUMMY_RESPONSE = '{' +
    '"data": [' +
    '{' +
    '"direccion": "Ignacio Mariategui 251-253, Cercado de Lima 15063",' +
    '"estado": {' +
    '"libres": 1,' +
    '"total": 3' +
    '},' +
    '"foto": null,' +
    '"horario": {' +
    '"dia_semana": null,' +
    '"fin_semana": null' +
    ' },' +
    '"id": 1,' +
    '"latitud": "-12.14809603",' +
    '"longitud": "-77.01725114",' +
    '"nombre": "Edificio LUM",' +
    '"tarifa": {' +
    '"lavado_autos": null,' +
    '"tarifa_hora": null' +
    ' }' +
    '   },' +
    '       {' +
    '        "direccion": "Av. Almte. Miguel Grau 701, Barranco 15063",' +
    '      "estado": {' +
    '          "libres": 2,' +
    '          "total": 4' +
    '       },' +
    '      "foto": null,' +
    '       "horario": {' +
    '             "dia_semana": "10:00-22:00",' +
    '           "fin_semana": "9:00-23:30"' +
    '        },' +
    '          "id": 3,' +
    '        "latitud": "-12.14435776",' +
    '           "longitud": "-77.02203620",' +
    '        "nombre": "Teatro Barranco",' +
    '      "tarifa": {' +
    '          "lavado_autos": 6.0,' +
    '          "tarifa_hora": 5.0' +
    '      }' +
    '       }' +
    ' ],' +
    '   "status_code": 200' +
    '}';
