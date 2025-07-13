import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../addcurrencyandcategory/presentation/screen/add_category.dart';
import '../../addcurrencyandcategory/presentation/screen/add_currency.dart';
import '../../items/presentaion/screen/addritems_responsive.dart';
import '../../items/presentaion/screen/edit_item.dart';
import '../../items/presentaion/screen/items_responsive.dart';
import '../../mange_orders/screen/Responsive_mangeorder.dart';
import '../../report/presentation/screen/view_report/view_report.dart';
import '../../users/presentation/view/user_responsive.dart';

part 'bar_state.dart';



class BarCubit extends Cubit<BarState> {
  BarCubit() : super(BarInitial());

  int selectedIndex = 0;
  int item = 0;

  void changePage(int index) {
    selectedIndex = index;
    emit(BarChanged(index));
  }

  void changeitems(int value) {
    item = value;
    emit(
      BottomItemSelected(
        state is BottomItemSelected ? (state as BottomItemSelected).index : 0,
      ),
    );
  }

  List<Widget> get pages => [
    const ResponsiveManageOrder(),
    AddritemsResponsive(),
    item == 0 ? ItemsResponsive() : const EditItem(),
    ViewReportScreen(),
    UserResponsive(),
    AddCurrency(),
    Addcategory(),
  ];
}
