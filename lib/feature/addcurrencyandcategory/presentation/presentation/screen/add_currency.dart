import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../manger/currency_cubit/currency_cubit.dart';
import '../widget/add_currency_phone.dart';

TextEditingController currency = TextEditingController();
TextEditingController currencyenglish = TextEditingController();

class AddCurrency extends StatelessWidget {
  const AddCurrency({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<CurrencyCubit>(),
      child: AddCurrencyPhone(
        currency: currency, currencyenglish: currencyenglish,),
    );
  }
}
