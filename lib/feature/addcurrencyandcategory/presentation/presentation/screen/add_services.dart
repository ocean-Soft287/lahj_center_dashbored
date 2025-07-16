import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../manger/services_cubit/services_cubit.dart';
import '../widget/add_service_phone.dart';

TextEditingController serviceArabic = TextEditingController();
TextEditingController serviceEnglish = TextEditingController();

class AddService extends StatelessWidget {
  const AddService({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<ServicesCubit>(),
      child: AddServicePhone(
        service: serviceArabic,
        serviceEnglish: serviceEnglish,
      ),
    );
  }
}
