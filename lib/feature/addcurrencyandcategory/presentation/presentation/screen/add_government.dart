import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/presentation/manger/governmentcubit/government_cubit.dart';

import '../widget/add_government_phone.dart';
TextEditingController government = TextEditingController();
TextEditingController governmentenglish = TextEditingController();

class AddGovernment extends StatelessWidget {
  const AddGovernment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<GovernmentCubit>(),
      child: AddGovernmentPhone(government: government, governmentenglish: governmentenglish,
    ));
  }
}
