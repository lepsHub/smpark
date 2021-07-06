import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:smpark/src/providers/list_provider.dart';

part 'list_state.dart';

class ListCubit extends Cubit<ListState> {
  ListCubit() : super(ListInitial());

  Future<void> fetchItems() async {

    List<ObjectPark> objectParkItems = List.generate(10, (index) => ObjectPark('Park$index','Status$index','https://picsum.photos/500/300/?Image=$index'));
    await Future.delayed(const Duration(seconds: 2));
    emit(ListLoadedState(objectParkItems));
  }

}
