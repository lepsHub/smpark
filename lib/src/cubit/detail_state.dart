part of 'detail_cubit.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object?> get props => [];
}

class DetailInitial extends DetailState {}

class LocationLoadedState extends DetailState {
  final double? lat;
  final double? long;
  LocationLoadedState(this.lat, this.long);

  @override
  List<Object?> get props => [this.lat, this.long];
}
