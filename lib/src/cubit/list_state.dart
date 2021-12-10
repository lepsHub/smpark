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
  List<Object?> get props => [items, stamp];
}

class AddressesLoadingState extends ListState {
  final int stamp = DateTime.now().millisecondsSinceEpoch;
  AddressesLoadingState();

  @override
  List<Object?> get props => [stamp];
}

class AddressesLoadedState extends ListState {
  final List<Results> items;
  final int stamp = DateTime.now().millisecondsSinceEpoch;
  AddressesLoadedState(this.items);
  @override
  List<Object?> get props => [items, stamp];
}

class ListEmptyState extends ListState {
  const ListEmptyState();
}

class ListErrorState extends ListState {
  const ListErrorState();
}