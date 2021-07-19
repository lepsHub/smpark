part of 'list_cubit.dart';

@immutable
abstract class ListState extends Equatable {
  const ListState();
  @override
  List<Object?> get props => [];
}

class ListInitial extends ListState {
  @override
  List<Object?> get props => [];
}

class ListLoadingState extends ListState {
  @override
  List<Object?> get props => [];
}

class ListLoadedState extends ListState {
  final List<ObjectPark> items;
  final int stamp = DateTime.now().millisecondsSinceEpoch;
  ListLoadedState(this.items);

  @override
  List<Object?> get props => [items];
}

class ListErrorState extends ListState {
  const ListErrorState();
}

class ListEmptyState extends ListState {
  const ListEmptyState();
}

class AddressLoadedState extends ListState {
  final List<ObjectPark> items;
  AddressLoadedState(this.items);

  @override
  List<Object?> get props => [items];
}
