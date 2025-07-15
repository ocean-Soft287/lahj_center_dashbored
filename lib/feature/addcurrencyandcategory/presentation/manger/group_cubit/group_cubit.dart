import 'package:bloc/bloc.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/data/model/group.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/data/repo/group_repo.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/Failure/failure.dart';

part 'group_state.dart';


class GroupCubit extends Cubit<GroupState> {
  final GroupRepo groupRepo;

  GroupCubit(this.groupRepo) : super(GroupInitial());

  List<Group> groups = [];

  Future<void> getGroups() async {
    final result = await groupRepo.getgroup();
    result.fold(
          (failure) => emit(GroupError(_mapFailureToMessage(failure))),
          (data) {
        groups = data;
        emit(GroupLoaded(List.from(groups)));
      },
    );
  }

  Future<void> addGroup(String arName, String enName) async {
    final result = await groupRepo.addgroup(arName, enName);
    result.fold(
          (failure) => emit(GroupActionError(_mapFailureToMessage(failure))),
          (addedGroup) {
        groups.add(addedGroup);
        emit(GroupAdded(addedGroup));
        _emitUpdatedGroups();
      },
    );
  }

  Future<void> updateGroup(int id, String arName, String enName) async {
    final result = await groupRepo.updategroup(id, arName, enName);
    result.fold(
          (failure) => emit(GroupActionError(_mapFailureToMessage(failure))),
          (updatedGroup) {
        final index = groups.indexWhere((g) => g.id == id);
        if (index != -1) {
          groups[index] = updatedGroup;
        }
        emit(GroupUpdated(updatedGroup));
        _emitUpdatedGroups();
      },
    );
  }

  Future<void> deleteGroup(int id) async {
    emit(GroupActionLoading());
    final result = await groupRepo.deletegroup(id);
    result.fold(
          (failure) => emit(GroupActionError(_mapFailureToMessage(failure))),
          (successMessage) {
        groups.removeWhere((g) => g.id == id);
        emit(GroupDeleted(successMessage));
        _emitUpdatedGroups();
      },
    );
  }

  void _emitUpdatedGroups() {
    emit(GroupLoaded(List.from(groups)));
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message ?? "حدث خطأ غير متوقع";
  }
}