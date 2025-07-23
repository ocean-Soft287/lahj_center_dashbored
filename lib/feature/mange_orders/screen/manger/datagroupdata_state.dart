part of 'datagroupdata_cubit.dart';

@immutable
abstract class DatagroupdataState {}

class DatagroupdataInitial extends DatagroupdataState {}

class DatagroupdataLoading extends DatagroupdataState {}

class DatagroupdataLoaded extends DatagroupdataState {
  final List<dynamic> data;

  DatagroupdataLoaded(this.data);
}

class DatagroupdataError extends DatagroupdataState {
  final String message;

  DatagroupdataError(this.message);
}
