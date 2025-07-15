import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/model/currency.dart';
import '../../../data/repo/currency_repo.dart';
part 'currency_state.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  final Currencyrepo currencyRepo;

  CurrencyCubit(this.currencyRepo) : super(CurrencyInitial());

  List<Currency> currencies = [];

  Future<void> getCurrencies() async {
    final result = await currencyRepo.getcurrency();
    result.fold(
          (failure) => emit(CurrencyError(failure.message)),
          (data) {
        currencies = data;
        emit(CurrencyLoaded(data));
      },
    );
  }

  Future<void> addCurrency(String arName, String enName) async {
    final result = await currencyRepo.addCurrency(arName, enName);
    result.fold(
          (failure) => emit(CurrencyActionError(failure.message)),
          (newCurrency) {
        currencies.add(newCurrency);
        emit(CurrencyAdded(newCurrency));
        emit(CurrencyLoaded(List.from(currencies)));
      },
    );
  }

  Future<void> updateCurrency(int id, String arName, String enName) async {
    final result = await currencyRepo.updateCurrency(id, arName, enName);
    result.fold(
          (failure) {
            print(failure.message);
            emit(CurrencyActionError(failure.message));
          },
          (updatedCurrency) {
        final index = currencies.indexWhere((c) => c.id == id);
        if (index != -1) {

          currencies[index] = updatedCurrency;

        }
        emit(CurrencyUpdated(updatedCurrency));
        emit(CurrencyLoaded(List.from(currencies)));
      },
    );
  }

  Future<void> deleteCurrency(int id) async {
    emit(CurrencyActionLoading());
    final result = await currencyRepo.deleteCurrency(id);
    result.fold(
          (failure) {
            emit(CurrencyActionError(failure.message));

          },
            (message) {
        currencies.removeWhere((c) => c.id == id);
        emit(CurrencyDeleted(message));
        emit(CurrencyLoaded(List.from(currencies)));
      },
    );
  }
}
