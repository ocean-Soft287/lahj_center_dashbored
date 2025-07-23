import 'package:bloc/bloc.dart';
import 'package:lahj_center/feature/items/data/repo/items_repo.dart';
import 'package:meta/meta.dart';

import '../../data/model/advertisminte.dart';

part 'add_item_state.dart';

class AddItemCubit extends Cubit<AddItemState> {
  final ItemsRepo itemsRepo;

  AddItemCubit({required this.itemsRepo}) : super(AddItemInitial());

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
    );

    result.fold(
          (failure) => emit(AddItemFailure(failure.message)),
          (advertisement) => emit(AddItemSuccess(advertisement)),
    );
  }
}
