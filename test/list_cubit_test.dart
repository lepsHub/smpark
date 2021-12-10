import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:smpark/api/service/service_service.dart';
import 'package:smpark/src/cubit/list_cubit.dart';
import 'package:smpark/src/providers/list_provider.dart';

import 'list_cubit_test.mocks.dart';

const double MOCK_LATITUDE = 1111.1;
const double MOCK_LONGITUDE = 1111.1;

@GenerateMocks([ServiceService, Location])
void main() {
  final items = List.generate(
      1,
      (index) => ObjectPark(
          index,
          MOCK_LATITUDE.toString(),
          MOCK_LONGITUDE.toString(),
          "nombre",
          Estado(10, 5),
          "direccion",
          "foto",
          Tarifa(10, 10),
          Horario("diaSemana", "finSemana"),
          List.generate(1, (index) => PuntosInteres("nombre", "url", "foto"))));

  late MockServiceService mockService;
  late MockLocation mockLocation;

  group('smpark tests', () {
    setUp(() {
      mockService = MockServiceService();
      mockLocation = MockLocation();
    });

    blocTest<ListCubit, ListState>("fetchItems filled",
        setUp: () {
          when(mockService.findServiceByFilter(any, any))
              .thenAnswer((_) async => ObjectParkWrapper(items));
          when(mockLocation.serviceEnabled()).thenAnswer((_) async => true);
          when(mockLocation.hasPermission())
              .thenAnswer((_) async => PermissionStatus.granted);
          when(mockLocation.getLocation())
              .thenAnswer((_) async => LocationData.fromMap({
                    "latitude": MOCK_LATITUDE,
                    "longitude": MOCK_LONGITUDE,
                    "accuracy": null,
                    "altitude": null,
                    "speed": null,
                    "speed_accuracy": null,
                    "heading": null,
                    "time": null,
                    "isMock": true,
                    "verticalAccuracy": null,
                    "headingAccuracy": null,
                    "elapsedRealtimeNanos": null,
                    "elapsedRealtimeUncertaintyNanos": null,
                    "satelliteNumber": null,
                    "provider": null,
                  }));
        },
        build: () => ListCubit(mockService, mockLocation),
        act: (c) => c.fetchItems(),
        expect: () => <ListState>[ListLoadedState(items)],
        verify: (_) {
          verify(mockLocation.serviceEnabled()).called(1);
          verify(mockLocation.hasPermission()).called(1);
          verify(mockLocation.getLocation()).called(1);
          verify(mockService.findServiceByFilter(any, any)).called(1);
        });

    blocTest<ListCubit, ListState>("fetchItems empty",
        setUp: () {
          when(mockService.findServiceByFilter(any, any))
              .thenAnswer((_) async => ObjectParkWrapper([]));
          when(mockLocation.serviceEnabled()).thenAnswer((_) async => true);
          when(mockLocation.hasPermission())
              .thenAnswer((_) async => PermissionStatus.granted);
          when(mockLocation.getLocation())
              .thenAnswer((_) async => LocationData.fromMap({
                    "latitude": MOCK_LATITUDE,
                    "longitude": MOCK_LONGITUDE,
                    "accuracy": null,
                    "altitude": null,
                    "speed": null,
                    "speed_accuracy": null,
                    "heading": null,
                    "time": null,
                    "isMock": true,
                    "verticalAccuracy": null,
                    "headingAccuracy": null,
                    "elapsedRealtimeNanos": null,
                    "elapsedRealtimeUncertaintyNanos": null,
                    "satelliteNumber": null,
                    "provider": null,
                  }));
        },
        build: () => ListCubit(mockService, mockLocation),
        act: (c) => c.fetchItems(),
        expect: () => <ListState>[ListEmptyState()],
        verify: (_) {
          verify(mockLocation.serviceEnabled()).called(1);
          verify(mockLocation.hasPermission()).called(1);
          verify(mockLocation.getLocation()).called(1);
          verify(mockService.findServiceByFilter(any, any)).called(1);
        });

    blocTest<ListCubit, ListState>("fetchItems No Service Enabled",
        setUp: () {
          when(mockService.findServiceByFilter(any, any))
              .thenAnswer((_) async => ObjectParkWrapper([]));
          when(mockLocation.serviceEnabled()).thenAnswer((_) async => false);
          when(mockLocation.requestService()).thenAnswer((_) async => false);
        },
        build: () => ListCubit(mockService, mockLocation),
        act: (c) => c.fetchItems(),
        expect: () => <ListState>[ListErrorState()],
        verify: (_) {
          verify(mockLocation.serviceEnabled()).called(1);
          verify(mockLocation.requestService()).called(1);
          verifyNever(mockLocation.getLocation());
          verifyNever(mockService.findServiceByFilter(any, any));
        });

    blocTest<ListCubit, ListState>(
        "fetchItems Has Service Enabled but No Permission",
        setUp: () {
          when(mockService.findServiceByFilter(any, any))
              .thenAnswer((_) async => ObjectParkWrapper([]));
          when(mockLocation.serviceEnabled()).thenAnswer((_) async => true);
          when(mockLocation.hasPermission())
              .thenAnswer((_) async => PermissionStatus.denied);
          when(mockLocation.requestPermission())
              .thenAnswer((_) async => PermissionStatus.denied);
        },
        build: () => ListCubit(mockService, mockLocation),
        act: (c) => c.fetchItems(),
        expect: () => <ListState>[ListErrorState()],
        verify: (_) {
          verify(mockLocation.serviceEnabled()).called(1);
          verify(mockLocation.hasPermission()).called(1);
          verify(mockLocation.requestPermission()).called(1);
        });

    blocTest<ListCubit, ListState>("fetchItems Has Service Eabled & Permission but No Location Found",
        setUp: () {
          when(mockService.findServiceByFilter(any, any))
              .thenAnswer((_) async => ObjectParkWrapper([]));
          when(mockLocation.serviceEnabled()).thenAnswer((_) async => true);
          when(mockLocation.hasPermission())
              .thenAnswer((_) async => PermissionStatus.granted);
          when(mockLocation.getLocation())
              .thenAnswer((_) async => LocationData.fromMap({
                    "latitude": null,
                    "longitude": null,
                    "accuracy": null,
                    "altitude": null,
                    "speed": null,
                    "speed_accuracy": null,
                    "heading": null,
                    "time": null,
                    "isMock": true,
                    "verticalAccuracy": null,
                    "headingAccuracy": null,
                    "elapsedRealtimeNanos": null,
                    "elapsedRealtimeUncertaintyNanos": null,
                    "satelliteNumber": null,
                    "provider": null,
                  }));
        },
        build: () => ListCubit(mockService, mockLocation),
        act: (c) => c.fetchItems(),
        expect: () => <ListState>[ListErrorState()],
        verify: (_) {
          verify(mockLocation.serviceEnabled()).called(1);
          verify(mockLocation.hasPermission()).called(1);
          verify(mockLocation.getLocation()).called(1);
        });
  });
}
