import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:lahj_center/feature/users/data/model/user_model.dart';
import 'package:lahj_center/feature/users/data/userrepo/user_repo.dart';
import 'package:lahj_center/core/utils/Failure/failure.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userRepo) : super(UserInitial());

  final UserRepo userRepo;

  List<User> users = [];

  void getUsers() async {

    final Either<Failure, List<User>> response = await userRepo.getuser();

    response.fold(
          (failure) => emit(UserError(_mapFailureToMessage(failure))),
          (data) {
        users = data;
        emit(UserLoaded(List<User>.from(data)));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message ?? 'حدث خطأ غير متوقع';
  }
}
