import 'package:bloc/bloc.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/data/repo/services_repo.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/Failure/failure.dart';
import '../../../data/model/services.dart';
part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  final ServicesRepo servicesRepo;

  ServicesCubit(this.servicesRepo) : super(ServicesInitial());

  List<Services> services = [];

  Future<void> getServices() async {
    emit(ServicesLoading());
    final result = await servicesRepo.getServices();
    result.fold(
          (failure) => emit(ServicesError(_mapFailureToMessage(failure))),
          (data) {
        services = data;
        emit(ServicesLoaded(List.from(services)));
      },
    );
  }

  Future<void> addService(String arName, String enName) async {
    final result = await servicesRepo.addServices(arName, enName);
    result.fold(
          (failure) => emit(ServicesActionError(_mapFailureToMessage(failure))),
          (addedService) {
        services.add(addedService);
        emit(ServiceAdded(addedService));
        _emitUpdatedServices();
      },
    );
  }

  Future<void> updateService(int id, String arName, String enName) async {
    final result = await servicesRepo.updateServices(id, arName, enName);
    result.fold(
          (failure) => emit(ServicesActionError(_mapFailureToMessage(failure))),
          (updatedService) {
        final index = services.indexWhere((s) => s.id == id);
        if (index != -1) {
          services[index] = updatedService;
        }
        emit(ServiceUpdated(updatedService));
        _emitUpdatedServices();
      },
    );
  }

  Future<void> deleteService(int id) async {
    emit(ServicesActionLoading());
    final result = await servicesRepo.deleteServices(id);
    result.fold(
          (failure) => emit(ServicesActionError(_mapFailureToMessage(failure))),
          (successMessage) {
        services.removeWhere((s) => s.id == id);
        emit(ServiceDeleted(successMessage));
        _emitUpdatedServices();
      },
    );
  }

  void _emitUpdatedServices() {
    emit(ServicesLoaded(List.from(services)));
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message ?? "حدث خطأ غير متوقع";
  }
}
