import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:tasha_task/data/local/my_hive.dart';
import 'package:tasha_task/models/services_model.dart';
import 'package:tasha_task/screens/app_screen.dart';
import 'package:tasha_task/screens/login_screen.dart';
import 'package:tasha_task/services/cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';

void navigateWithReplacement({required context, required Widget widget}) =>
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ));

void navigate({required context, required Widget widget}) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

Widget mainTextField(
        {required TextEditingController? controller,
        required String? Function(String?)? validator,
        String? text,
        required TextInputType? keyboardType,
        void Function()? onTap,
          TextStyle? style,
        int minLines = 1,
        int maxLines = 1}) =>
    TextFormField(
      minLines: minLines,
      maxLines: maxLines,
      onTap: onTap,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      style: style,
      cursorColor: HexColor('#6259A8'),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 15),
        hintText: text,
        filled: true,
        fillColor: Colors.grey[200],
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(width: 0, style: BorderStyle.none)),
      ),
    );

Widget mainButton(
        {required String text,
        required void Function()? onPressed,
        Color borderColor = Colors.transparent,
        required Color backgroundColor,
        required Color textColor}) =>
    Row(
      children: [
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  side: BorderSide(color: borderColor, width: 1.5),
                  fixedSize: Size(double.infinity, 50),
                  primary: backgroundColor),
              onPressed: onPressed,
              child: Text(text,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: textColor,
                  ))),
        )
      ],
    );

Widget buildSearchbar(
        {required String hintText,
        // required void Function()? onPressed,
        required void Function()? onTap,
TextEditingController? controller,
        required void Function(String)? onChanged}) =>
    Row(children: [
      Expanded(
        child: TextField(
          controller:controller ,
          onChanged: onChanged,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              filled: true,
              fillColor: Colors.grey[300],
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 0, style: BorderStyle.none)),
              prefixIcon: Icon(Icons.search),
              hintText: hintText,
              hintStyle: TextStyle(fontSize: 14)),
        ),
      ),
      SizedBox(width: 11.w),
      InkWell(
        onTap: onTap,
        child: Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
                color: HexColor('#6259A8'),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              Icons.ac_unit,
              color: Colors.white,
            )),
      ),
    ]);

Widget buildHotelContainer(
        {required ServiceData model,
        // bool isSale = false,
        bool withPrice = true,
        required void Function(ServiceData model)? onTap}) =>
    InkWell(
      onTap: () {
        onTap!(model);
      },
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 2,
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  width: double.infinity,
                  height: 100.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          height: 120.h,
                          width: 90.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10)),
                          child: mainCachedImage(
                              url: model.pictures!.length > 0
                                  ? 'http://tasha.accessline.ps//Files/${model.pictures?[0].fileName ?? ''}'
                                  : ''),
                        ),
                        SizedBox(width: 15.w),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.name!,
                              style: TextStyle(
                                  fontSize: 13.sp, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 6.h),
                            Container(
                              height: 20.h,
                              width: 200.w,
                              child: RatingBar.builder(
                                ignoreGestures: true,
                                unratedColor: Colors.grey[400],
                                itemSize: 20,
                                initialRating: (model.rate)!.toDouble(),
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.only(left: 5),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ),
                            SizedBox(height: 1.5.h),
                            Text(
                              model.description!,
                              style: TextStyle(fontSize: 10.sp),
                            ),
                            SizedBox(height: 4.h),
                            if (withPrice == true)
                              Row(
                                children: [
                                  Text(model.defaultPrice.toString(),
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: HexColor('#6259A8'))),
                                  SizedBox(width: 3.w),
                                  FaIcon(
                                    FontAwesomeIcons.shekelSign,
                                    size: 12.sp,
                                    color: HexColor('#6259A8'),
                                  )
                                ],
                              ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                // Container(
                //   alignment: Alignment.topCenter,
                //   decoration: BoxDecoration(
                //     color: HexColor('#F04B6D'),
                //   ),
                //   height: 38.h,
                //   width: 36.w,
                //   child: Text(
                //     'خصم\n 10%',
                //     style: TextStyle(
                //       fontSize: 11,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),

          // if (isSale == true)
          if (model.discount != 0)
            Positioned(
              top: -5,
              child: Padding(
                  padding: const EdgeInsets.only(left: 14, top: 0),
                  child: Container(
                    height: 60,
                    width: 60,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.bookmark,
                          color: HexColor('#F04B6D'),
                          size: 60,
                        ),
                        Text(
                          'خصم\n ${model.discount}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  )),
            ),
        ],
      ),
    );

PreferredSizeWidget buildAppBar({
  required BuildContext context,
  required String appBarTitle,
  List<Widget>? actions,
  Color color = Colors.black,
  // required void Function()? onPressed
}) =>
    AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: color),
      // leading: IconButton(
      //   icon: Icon(Icons.arrow_back, color: color),
      //   onPressed: onPressed,
      // ),
      actions: actions,
      title: Text(
        appBarTitle,
        style:
            TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );

Widget mainTextButton(
        {required String text,
        required BuildContext context,
        required Widget navigateTo}) =>
    TextButton(
        style: ButtonStyle(alignment: Alignment.centerRight),
        onPressed: () => navigate(context: context, widget: navigateTo),
        child: Padding(
          padding: const EdgeInsets.only(right: 0),
          child: Text(
            text,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w300),
          ),
        ));

void logout({
  required BuildContext context,
}) {
  // MyHive.removeObject();
  navigateWithReplacement(context: context, widget: LoginScreen());
}

Widget mainCachedImage({required String url}) => CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Icon(
        Icons.error,
        color: Colors.grey[500],
      ),
      fit: BoxFit.cover,
    );

void buildReservation({required bool isAccept}) {
  var state = isAccept ? 'مقبول' : 'مرفوض';
  Container(
    height: 135.h,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                height: 80.h,
                width: 80.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            'https://pix10.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?ca=6&ce=1&s=1024x768'),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'شاليه الشروق',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'بداية الحجز ',
                    style: TextStyle(fontSize: 11.sp),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'نهاية الحجز ',
                    style: TextStyle(fontSize: 11.sp),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'تكلفة الحجز ',
                    style: TextStyle(fontSize: 11.sp),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 8.h),
          Container(
              alignment: Alignment.center,
              width: 125.w,
              height: 28.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: isAccept ? HexColor('#65B95C') : Colors.grey.shade300),
              child: Text(
                ' ${state} الطلب',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                  color: isAccept ? Colors.white : Colors.black,
                ),
              ))
        ],
      ),
    ),
  );
}
