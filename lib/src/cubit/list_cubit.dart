import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:smpark/src/providers/list_provider.dart';

part 'list_state.dart';

class ListCubit extends Cubit<ListState> {
  ListCubit() : super(ListInitial());

  Future<void> fetchItems() async {
    var status = ["GREEN", "YELLOW", "RED"];

    List<ObjectPark> objectParkItems = List.generate(10, (index) {
      var state = status[Random().nextInt(3)];
      print("$index $state");
      return ObjectPark(
          'Park$index', state, 'https://picsum.photos/500/300/?Image=$index');
    });
    await Future.delayed(const Duration(seconds: 2));
    emit(ListLoadedState(objectParkItems));
  }
}
