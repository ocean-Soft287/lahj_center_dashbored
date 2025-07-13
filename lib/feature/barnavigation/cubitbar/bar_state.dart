part of 'bar_cubit.dart';

@immutable
abstract class BarState {}

class BarInitial extends BarState {}

class BarChanged extends BarState {
  final int index;
  BarChanged(this.index);
}

class BottomItemSelected extends BarState {
  final int index;
  BottomItemSelected(this.index);
}
