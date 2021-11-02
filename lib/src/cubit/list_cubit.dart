import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:smpark/api/service/service_service.dart';
import 'package:smpark/src/providers/list_provider.dart';

part 'list_state.dart';

class ListCubit extends Cubit<ListState> {
  final ServiceService service;
  final Location location;
  ListCubit(this.service, this.location) : super(ListInitial());

  Future<void> fetchItems() async {
    /*
    List<ObjectPark> objectParkItems = List.generate(10, (index) {
      return ObjectPark(
        index,
        "-12.175029073735226",
        "-77.01284083757179",
        "Park $index",
        Estado(20, Random().nextInt(19)),
        "Av Siempre Viva, Springfield",
        'https://picsum.photos/500/300/?Image=$index',
        Tarifa(15, 29),
        Horario("L -V", "S - D"),
        List.generate(
            6,
            (index) => PuntosInteres(
                "Foto $index",
                'https://picsum.photos/500/300/?Image=$index',
                'https://picsum.photos/500/300/?Image=$index')),
      );
    });

    emit(ListLoadingState());

    await Future.delayed(const Duration(seconds: 2));
    */


    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        emit(ListErrorState());
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        emit(ListErrorState());
        return;
      }
    }

    var locationData = await location.getLocation();
    if (locationData.latitude == null || locationData.longitude == null) {
      emit(ListErrorState());
      return;
    }

    try {
      var objectParkItems = await service.findServiceByFilter(
          locationData.latitude!, locationData.longitude!);
      if (objectParkItems.items.isNotEmpty)
        emit(ListLoadedState(objectParkItems.items));
      else
        emit(ListEmptyState());
    } catch (e) {
      emit(ListErrorState());
    }
  }

  Future<void> searchAddress(String address) async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        emit(ListErrorState());
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        emit(ListErrorState());
        return;
      }
    }

    var locationData = await location.getLocation();
    if (locationData.latitude == null || locationData.longitude == null) {
      emit(ListErrorState());
      return;
    }

    var objectParkItems = await service.findCordsByDesc(
        address, locationData.latitude!, locationData.longitude!);

    print(objectParkItems.status);
  }
}
