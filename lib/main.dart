import 'package:flutter/material.dart';
import 'package:tasha_task/config/themes/color.dart';
import 'package:tasha_task/data/local/cashe_helper.dart';
import 'package:tasha_task/features/getServicesCubit.dart';
import 'package:tasha_task/observer.dart';
import 'package:tasha_task/screens/app_screen.dart';
import 'package:tasha_task/screens/drawer_pages/manager_request_screen.dart';
import 'package:tasha_task/screens/login_screen.dart';
import 'package:tasha_task/screens/menu_screen.dart';
import 'package:tasha_task/screens/pay_method.dart';
import 'package:tasha_task/screens/phone.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasha_task/screens/register.dart';
import 'package:tasha_task/screens/search_screen.dart';
import 'package:tasha_task/screens/services/specific_service/resturant_data.dart';
import 'package:tasha_task/screens/start_screen.dart';
import 'package:tasha_task/services/cubit.dart';
import 'package:tasha_task/shared/constants.dart';
import 'package:localization/localization.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  // token = CashHelper.getData(key: CashHelper.token);
  Widget startWidget;

  if (token != null) {
    startWidget = StartScreen();
  } else {
    startWidget = LoginScreen();
  }
  Bloc.observer = MyBlocObserver();
  runApp(MyApp(startWidget: startWidget));
}

class MyApp extends StatelessWidget {
  Widget startWidget;
  MyApp({Key? key, required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      splitScreenMode: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>(
            create: (context) => AppCubit()..getCountries(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            // delegate from flutter_localization
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            // delegate from localization package.
            // LocalJsonLocalization.delegate,
          ],
          supportedLocales: [Locale('ar')],
          locale: Locale('ar'),
          home: StartScreen(),
          theme: ThemeData(
              // primaryColor: defaultColor,
              // iconTheme: IconThemeData(color: Colors.black),
              fontFamily: Font.fontFamily(),
              appBarTheme:
                  AppBarTheme(backgroundColor: Colors.white, elevation: 0),
              scaffoldBackgroundColor: Colors.white),
        ),
      ),
    );
  }
}

class Font {
  static String fontFamily() => 'Almarai';
}
