import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tasha_task/screens/login_screen.dart';
import 'package:tasha_task/services/cubit.dart';
import 'package:tasha_task/shared/components.dart';
import 'package:flutter_screenutil/src/size_extension.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#6259A8'),
      appBar: AppBar(
        backgroundColor: HexColor('#6259A8'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    height: 230.h,
                    child: ListView.separated(
                        itemBuilder: (context, index) => mainTextButton(
                            text: AppCubit.get(context).list[index]['text'],
                            context: context,
                            navigateTo: AppCubit.get(context).list[index]
                                ['navigateTo']),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 15.h,
                            ),
                        itemCount: AppCubit.get(context).list.length)),
                Divider(
                  color: Colors.white.withOpacity(0.5),
                  endIndent: 50,
                  indent: 20,
                  thickness: 2,
                ),
                InkWell(
                  onTap: () => logout(context: context),
                  child: ListTile(
                    leading: Icon(Icons.logout, color: Colors.white),
                    title: Text(
                      'تسجيل خروج',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
