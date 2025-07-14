part of 'currency_cubit.dart';

@immutable
abstract class CurrencyState {}

class CurrencyInitial extends CurrencyState {}

class CurrencyLoading extends CurrencyState {}

class CurrencyLoaded extends CurrencyState {
  final List<Currency> currencies;

  CurrencyLoaded(this.currencies);
}

class CurrencyError extends CurrencyState {
  final String message;

  CurrencyError(this.message);
}

// لحالات الإضافة/التعديل/الحذف
class CurrencyActionLoading extends CurrencyState {}

class CurrencyAdded extends CurrencyState {
  final Currency currency;

  CurrencyAdded(this.currency);
}

class CurrencyUpdated extends CurrencyState {
  final Currency currency;

  CurrencyUpdated(this.currency);
}

class CurrencyDeleted extends CurrencyState {
  final String message;

  CurrencyDeleted(this.message);
}

class CurrencyActionError extends CurrencyState {
  final String message;

  CurrencyActionError(this.message);
}
