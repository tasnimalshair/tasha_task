import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tasha_task/screens/search_screen.dart';
import 'package:tasha_task/services/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasha_task/services/states.dart';

class AppScreen extends StatefulWidget {
  final drawerController;
  AppScreen({Key? key, required this.drawerController}) : super(key: key);

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit.get(context).drawerControllerIn = widget.drawerController;
        return Scaffold(
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 8.0,
            elevation: 20,
            clipBehavior: Clip.antiAlias,
            child: Container(
              height: 60,
              child: BottomNavigationBar(
                  unselectedItemColor: Colors.black,
                  selectedItemColor: Colors.black,
                  unselectedIconTheme: IconThemeData(color: Colors.grey),
                  type: BottomNavigationBarType.fixed,
                  iconSize: 25,
                  unselectedLabelStyle: TextStyle(fontSize: 11),
                  selectedLabelStyle: TextStyle(fontSize: 11),
                  showUnselectedLabels: true,
                  showSelectedLabels: true,
                  selectedIconTheme: IconThemeData(
                    color: HexColor('#6259A8'),
                  ),
                  currentIndex: AppCubit.get(context).currentIndex,
                  onTap: (index) => AppCubit.get(context)
                      .changeBottomNavigationBarIndex(index),
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'الرئيسية'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.reviews_rounded), label: 'حجوزاتي'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.place), label: 'أماكن قريبة'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person), label: 'الملف الشخصي'),
                  ]),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.search),
            backgroundColor: HexColor('#6259A8'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ));
            },
          ),
          body: AppCubit.get(context)
              .bottoNavigationWidgets[AppCubit.get(context).currentIndex],
        );
      },
    );
  }
}
