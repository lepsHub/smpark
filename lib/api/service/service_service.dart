import 'package:smpark/api/service_api.dart';
import 'package:smpark/src/providers/list_provider.dart';

abstract class ServiceService {
  Future<List<ObjectPark>> findServiceByFilter(
      double latitud, double longitude);
}

class ServiceServiceImpl implements ServiceService {
  final ServiceAPI _api;
  const ServiceServiceImpl(this._api);

  @override
  Future<List<ObjectPark>> findServiceByFilter(
          double latitud, double longitude) =>
      _api.consumeGet(
          ServiceConstants.SERVICE_BY_COLLAB_PATH + "$latitud/$longitude");
}
