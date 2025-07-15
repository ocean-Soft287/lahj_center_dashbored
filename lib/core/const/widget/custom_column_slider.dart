import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahj_center/core/utils/colors/colors.dart';
import 'package:lahj_center/core/utils/image/images.dart';
import '../../../feature/barnavigation/cubitbar/bar_cubit.dart';
import '../../utils/appstyle/size_config.dart';
import 'menu_item.dart';

class CustomColumnSlider extends StatelessWidget {
  const CustomColumnSlider({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    bool isMobile = SizeConfig.width < 800;

    final cubit = context.watch<BarCubit>();

    return Scaffold(
      backgroundColor: Appcolors.kwhite,
      key: GlobalKey<ScaffoldState>(),
      appBar: isMobile
          ? AppBar(
        backgroundColor: Appcolors.kwhite,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      )
          : null,
      drawer: isMobile ? Drawer(child: _buildMenu(context, cubit)) : null,
      body: SafeArea(
        child: Row(
          children: [
            if (!isMobile)
              SizedBox(
                width: SizeConfig.width < 1200
                    ? 0.30 * SizeConfig.width
                    : 0.20 * SizeConfig.width,
                child: _buildMenu(context, cubit),
              ),
            Expanded(
              child: BlocBuilder<BarCubit, BarState>(
                builder: (context, state) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                              begin: const Offset(0.1, 0), end: Offset.zero)
                              .animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: cubit.pages[cubit.selectedIndex],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenu(BuildContext context, BarCubit cubit) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Appcolors.kprimary.withOpacity(0.30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Image.asset(
                Images.logo,
                width: 50,
                height: 50,
              ),
            ),
            const SizedBox(height: 30),
            MenuItem(
              title: "الصفحة الرئيسيه",
              icon: Images.home,
              isSelected: cubit.selectedIndex == 0,
              onTap: () => cubit.changePage(0),
            ),
            MenuItem(
              title: "اضافه منتجات",
              icon: Images.additem,
              isSelected: cubit.selectedIndex == 1,
              onTap: () => cubit.changePage(1),
            ),
            MenuItem(
              title: "المنتجات",
              icon: Images.shoppingbag,
              isSelected: cubit.selectedIndex == 2,
              onTap: () {
                cubit.changeitems(0);
                cubit.changePage(2);

              }      ),
            MenuItem(
              title: "بلاغ عن التعليقات",
              icon: Images.alert,
              isSelected: cubit.selectedIndex == 3,
              onTap: () => cubit.changePage(3),
            ),
            MenuItem(
              title: "اداره المستخدمين",
              icon: Images.accounts,
              isSelected: cubit.selectedIndex == 4,
              onTap: () => cubit.changePage(4),
            ),

            MenuItem(
              title: "اضافه عملات",
              icon: Images.currency,
              isSelected: cubit.selectedIndex == 5,
              onTap: () {
    cubit.changeitems(0);
    cubit.changePage(5);
    }

            ),
            MenuItem(
              title: "اضافه فئات",
              icon: Images.addcategory,
              isSelected: cubit.selectedIndex == 6,
              onTap: () {
                cubit. changeitems(0);
                cubit.changePage(6);

              }    ),
            const Spacer(),
            Container(
              alignment: Alignment.centerRight,
              width: 50,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "تسجيل الخروج",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
