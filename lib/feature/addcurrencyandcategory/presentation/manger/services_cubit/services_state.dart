part of 'services_cubit.dart';

@immutable
abstract class ServicesState {}

class ServicesInitial extends ServicesState {}

class ServicesLoading extends ServicesState {}

class ServicesLoaded extends ServicesState {
  final List<Services> services;

  ServicesLoaded(this.services);
}

class ServicesError extends ServicesState {
  final String message;

  ServicesError(this.message);
}

class ServicesActionLoading extends ServicesState {}

class ServicesActionError extends ServicesState {
  final String message;

  ServicesActionError(this.message);
}

class ServiceAdded extends ServicesState {
  final Services service;

  ServiceAdded(this.service);
}

class ServiceUpdated extends ServicesState {
  final Services service;

  ServiceUpdated(this.service);
}

class ServiceDeleted extends ServicesState {
  final String message;

  ServiceDeleted(this.message);
}
