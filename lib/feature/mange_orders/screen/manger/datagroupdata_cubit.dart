import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Data/data/data_number_repo.dart';

part 'datagroupdata_state.dart';

class DatagroupdataCubit extends Cubit<DatagroupdataState> {
  DatagroupdataCubit(this.datanumberrepo) : super(DatagroupdataInitial());

  final Datanumberrepo datanumberrepo;

  Future<void> getDataNumber() async {
    emit(DatagroupdataLoading());

    final response = await datanumberrepo.datagroupdatanumber();

    response.fold(
          (failure) {
        emit(DatagroupdataError(_mapFailureToMessage(failure)));
      },
          (data) {
        emit(DatagroupdataLoaded(data));
      },
    );
  }

  String _mapFailureToMessage(dynamic failure) {
    // هنا تكتب الرسائل حسب نوع الفشل
    return 'حدث خطأ ما';
  }
}
