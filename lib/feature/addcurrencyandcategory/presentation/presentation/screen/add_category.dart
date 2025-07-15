import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/presentation/manger/group_cubit/group_cubit.dart';
import '../widget/addcategoryphone.dart';

TextEditingController categoryarabic = TextEditingController();
TextEditingController categoryEnglish = TextEditingController();

class Addcategory extends StatelessWidget {
  const Addcategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<GroupCubit>(),
      child: Addcategoryphone(
        category: categoryarabic, categoryenglish: categoryEnglish,),
    );
  }
}
