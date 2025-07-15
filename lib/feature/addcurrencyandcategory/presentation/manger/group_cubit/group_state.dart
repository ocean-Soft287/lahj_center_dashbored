part of 'group_cubit.dart';

@immutable
abstract class GroupState {}

class GroupInitial extends GroupState {}

class GroupLoading extends GroupState {}

class GroupLoaded extends GroupState {
  final List<Group> groups;

  GroupLoaded(this.groups);
}

class GroupError extends GroupState {
  final String message;

  GroupError(this.message);
}

class GroupActionLoading extends GroupState {}

class GroupActionError extends GroupState {
  final String message;

  GroupActionError(this.message);
}

class GroupAdded extends GroupState {
  final Group group;

  GroupAdded(this.group);
}

class GroupUpdated extends GroupState {
  final Group group;

  GroupUpdated(this.group);
}

class GroupDeleted extends GroupState {
  final String message;

  GroupDeleted(this.message);
}
