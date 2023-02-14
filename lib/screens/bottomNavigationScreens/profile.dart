import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tasha_task/data/local/my_hive.dart';
import 'package:tasha_task/screens/app_screen.dart';
import 'package:tasha_task/screens/edit_screen.dart';
import 'package:tasha_task/shared/components.dart';
import 'package:flutter_screenutil/src/size_extension.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({Key? key}) : super(key: key);

  var names=['الاسم','العنوان','تاريخ الميلاد','البلد','رقم الجوال','الجنس'];
  var uName=MyHive.getUser(0)!.userVM!.firstName! + ' ' + MyHive.getUser(0)!.userVM!.lastName!;
  var data=[
    MyHive.getUser(0)!.userVM!.firstName!,
  MyHive.getUser(0)!.userVM!.addressDetails,
  MyHive.getUser(0)!.userVM!.birthDate,
  MyHive.getUser(0)!.userVM!.cityName,
  MyHive.getUser(0)!.userVM!.mobileNumber,
  MyHive.getUser(0)!.userVM!.genderName

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(
        //  onPressed: () => navigate(context: context, widget: AppScreen()),
          color: Colors.white,
          context: context,
          appBarTitle: 'الملف الشخصي',
          actions: [
            IconButton(onPressed: () {
              navigate(context: context, widget: EditScreen());
            }, icon: Icon(Icons.edit, color: Colors.white))
          ]),
      body: Column(children: [
        Stack( // overflow: Overflow.visible,
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Stack(
              children: [
                Container(
                  height: 162.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: HexColor('#6259A8'),
                    image: DecorationImage(
                        image: AssetImage('assets/images/png/background.png'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Positioned(
                    left: -10.w,
                    top: -10.h,
                    child: Image.asset('assets/images/png/up.png')),
                Positioned(
                    left: -35.w,
                    top: 20.h,
                    child: Image.asset('assets/images/png/below.png')),
                Positioned(
                    bottom: -5.h,
                    right: -5.w,
                    child: Image.asset('assets/images/png/rec.png')),
              ],
            ),
            Positioned(
              top: 110.h,
              child: Container(
                clipBehavior: Clip.antiAlias,
                height: 112.h,
                width: 112.w,
                child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQG2Pkls166NTLTXLIMRbhRCVk5M370zanuDFBnzBPMVhyHAh8ZsiVrr9noLPlmEwwxeak&usqp=CAU',
                      ),
                    )),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 55.h),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 400,
                child: ListView.separated(
                    padding: EdgeInsets.only(top: 5.h),
                    itemBuilder: (context, index) => buildUserData(),
                    separatorBuilder: (context, index) => Divider(
                          height: 15,
                        ),
                    itemCount: 7),
              ),
            ),
            // Image.asset('assets/images/png/plant.png'),
          ],
        )
      ]),
    );
  }

  Widget buildUserData(int index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            names[index],
            style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w300,
                color: HexColor('#A4A4A4')),
          ),
          SizedBox(height: 8.h),
          Text(data[index]!, style: TextStyle(fontSize: 14.sp)),
          // MyHive.getUser(0)!.userVM!.firstName!
        ],
      );
}
