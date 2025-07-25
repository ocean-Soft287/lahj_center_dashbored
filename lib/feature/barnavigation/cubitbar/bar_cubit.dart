import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/presentation/manger/governmentcubit/government_cubit.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/presentation/manger/services_cubit/services_cubit.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/presentation/presentation/screen/service_data_page.dart';
import '../../addcurrencyandcategory/presentation/manger/currency_cubit/currency_cubit.dart';
import '../../addcurrencyandcategory/presentation/manger/group_cubit/group_cubit.dart';
import '../../addcurrencyandcategory/presentation/presentation/screen/add_category.dart';
import '../../addcurrencyandcategory/presentation/presentation/screen/add_currency.dart';
import '../../addcurrencyandcategory/presentation/presentation/screen/add_government.dart';
import '../../addcurrencyandcategory/presentation/presentation/screen/add_services.dart';
import '../../addcurrencyandcategory/presentation/presentation/screen/currency_data_page.dart';
import '../../addcurrencyandcategory/presentation/presentation/screen/category_data_page.dart';
import '../../addcurrencyandcategory/presentation/presentation/screen/government_data_page.dart';
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
    item == 0 ? AddCurrency() : CurrencyDataPage(),
    item == 0 ? Addcategory() : CategoryDataPage(),

item==0?AddService():ServiceDataPage(),
    item == 0 ?   AddGovernment():GovernmentDataPage()
  ];
}
