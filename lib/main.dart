import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/blocObserver.dart';
import 'core/utils/font/fonts.dart';
import 'core/utils/route/approutes.dart';
import 'core/utils/services/services_locator.dart';
import 'feature/barnavigation/cubitbar/bar_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setup();

  Bloc.observer = MyBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: [

        BlocProvider<BarCubit>(
          create: (context) => BarCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'تطبيق Flutter',
      theme: ThemeData(
        fontFamily: Fonts.cairo,
      ),
      locale: const Locale('ar'),
      supportedLocales: const [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (locale != null &&
              locale.languageCode == supportedLocale.languageCode) {
            return supportedLocale;
          }
        }
        return const Locale('ar');
      },
      initialRoute: Routes.login,
      onGenerateRoute: AppRouter.getRoute,
    );
  }
}
