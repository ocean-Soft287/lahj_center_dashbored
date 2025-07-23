part of 'add_item_cubit.dart';

@immutable
abstract class AddItemState {}

class AddItemInitial extends AddItemState {}

class AddItemLoading extends AddItemState {}

class AddItemSuccess extends AddItemState {
  final Advertisement advertisement;

  AddItemSuccess(this.advertisement);
}

class AddItemFailure extends AddItemState {
  final String message;

  AddItemFailure(this.message);
}
