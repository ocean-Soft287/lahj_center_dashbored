import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/data/model/government.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/data/repo/government_repo.dart';
import 'package:lahj_center/core/utils/Failure/failure.dart';
part 'government_state.dart';


class GovernmentCubit extends Cubit<GovernmentState> {
  final Governmentrepo governmentrepo;

  GovernmentCubit(this.governmentrepo) : super(GovernmentInitial());

  List<Government> governments = [];

  Future<void> getGovernments() async {
    emit(GovernmentLoading());
    final result = await governmentrepo.getGovernment();
    result.fold(
          (failure) {
            print(failure.message);
            emit(GovernmentError(_mapFailureToMessage(failure)));
          },
          (data) {
        governments = data;
        emit(GovernmentLoaded(List.from(governments)));
      },
    );
  }

  Future<void> addGovernment(String arName, String enName) async {
    final result = await governmentrepo.addGovernment(arName, enName);
    result.fold(
          (failure) => emit(GovernmentActionError(_mapFailureToMessage(failure))),
          (addedGov) {
        governments.add(addedGov);
        emit(GovernmentAdded(addedGov));
        _emitUpdatedGovernments();
      },
    );
  }

  Future<void> updateGovernment(int id, String arName, String enName) async {
    final result = await governmentrepo.updateGovernment(id, arName, enName);
    result.fold(
          (failure) => emit(GovernmentActionError(_mapFailureToMessage(failure))),
          (updatedGov) {
        final index = governments.indexWhere((g) => g.id == id);
        if (index != -1) {
          governments[index] = updatedGov;
        }
        emit(GovernmentUpdated(updatedGov));
        _emitUpdatedGovernments();
      },
    );
  }

  Future<void> deleteGovernment(int id) async {
    emit(GovernmentActionLoading());
    final result = await governmentrepo.deleteGovernment(id);
    result.fold(
          (failure) => emit(GovernmentActionError(_mapFailureToMessage(failure))),
          (successMessage) {
        governments.removeWhere((g) => g.id == id);
        emit(GovernmentDeleted(successMessage));
        _emitUpdatedGovernments();
      },
    );
  }

  void _emitUpdatedGovernments() {
    emit(GovernmentLoaded(List.from(governments)));
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message ?? "حدث خطأ غير متوقع";
  }
}
