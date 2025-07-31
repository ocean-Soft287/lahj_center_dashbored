import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:lahj_center/feature/items/data/repo/items_repo.dart';
import 'package:meta/meta.dart';

import '../../data/model/advertisminte.dart';

part 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  final ItemsRepo itemsRepo;

  ItemCubit({required this.itemsRepo}) : super(AddItemInitial());

  Future<void> addAdvertisement({
    required String name,
    required String phone,
    required int groupId,
    required int serviceId,
    required int price,
    required int currency,
    required int governorateId,
    required String area,
    required String description,
    required List<File>X
  }) async {
    emit(AddItemLoading());

    final result = await itemsRepo.addadvertisminte(
        name,
        phone,
        groupId,
        serviceId,
        price,
        currency,
        governorateId,
        area,
        description,
        X
    );

    result.fold(
          (failure) => emit(AddItemFailure(failure.message)),
          (advertisement) => emit(AddItemSuccess(advertisement)),
    );
  }

  Future<void> getaddvertisminte() async {
    final response = await itemsRepo.getalladvertisminte();

    response.fold(
          (failure) => emit(FetchitemFailure(failure.message)),
          (advertisement) => emit(Fetchitemssuccful(alladvertisminte: advertisement)),
    );
  }
  Future<void> approvalPost(int x) async {
    final response = await itemsRepo.approval(x);

    response.fold(
          (failure) => emit(ApprovalFailure(message: failure.message)),
          (advertisement) => emit(Approvalsucces(message: advertisement)),
    );
  }

  void deletemyadd(int id,String reason)async{
    final response=await itemsRepo.deletemyadd(id, reason);

    response.fold((failure)=>emit(DeletemyadditemFailure()),(success)=> Deletemyadditemsuccful(success));
    getaddvertisminte();


  }


}




