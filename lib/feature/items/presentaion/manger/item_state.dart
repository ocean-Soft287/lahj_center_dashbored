part of 'item_cubit.dart';

@immutable
abstract class ItemState {}

class AddItemInitial extends ItemState {}

class AddItemLoading extends ItemState {}

class AddItemSuccess extends ItemState {
  final Item advertisement;

  AddItemSuccess(this.advertisement);
}

class AddItemFailure extends ItemState {
  final String message;

  AddItemFailure(this.message);
}

class Fetchitemssuccful extends ItemState{
  final List<Item>alladvertisminte;

  Fetchitemssuccful({required this.alladvertisminte});


}

class FetchitemFailure extends ItemState {
  final String message;

  FetchitemFailure(this.message);
}

class Approvalsucces extends ItemState {
  final String message;

  Approvalsucces({required this.message});

}

class ApprovalFailure extends ItemState {
  final String message;

  ApprovalFailure({required this.message});

}

class DeletemyadditemFailure extends ItemState{}
class Deletemyadditemsuccful extends ItemState{
final String message;

  Deletemyadditemsuccful(this.message);
}