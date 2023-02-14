import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:tasha_task/screens/app_screen.dart';
import 'package:tasha_task/screens/menu_screen.dart';

class StartScreen extends StatelessWidget {
   StartScreen({Key? key}) : super(key: key);

  final drawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomDrawer(
        controller: drawerController,
        menuScreen: MenuScreen(),
       mainScreen: AppScreen(drawerController: drawerController),
       style: DrawerStyle.defaultStyle,
       borderRadius: 24,
       showShadow: true,
       menuBackgroundColor: Colors.grey[300]!,
       slideWidth: MediaQuery.of(context).size.width * 0.45,
       openCurve: Curves.fastOutSlowIn,
       closeCurve: Curves.bounceIn,
       ),
    );
  }
}
