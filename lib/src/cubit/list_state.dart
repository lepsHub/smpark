part of 'list_cubit.dart';

@immutable
abstract class ListState extends Equatable{}

class ListInitial extends ListState {
  @override
  List<Object?> get props => [];
}

class ListLoadedState extends ListState {
  final List<ObjectPark> items;
  ListLoadedState(this.items);

  @override
  List<Object?> get props => [items];
  
}
