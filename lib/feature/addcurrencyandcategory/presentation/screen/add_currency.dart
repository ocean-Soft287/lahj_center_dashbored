import 'package:flutter/cupertino.dart';

import '../widget/add_currency_phone.dart';
TextEditingController currency=TextEditingController();
TextEditingController currencyenglish=TextEditingController();
class AddCurrency extends StatelessWidget {
  const AddCurrency({super.key});

  @override

  Widget build(BuildContext context) {
    return AddCurrencyPhone(currency: currency, currencyenglish: currencyenglish,);
  }
}
