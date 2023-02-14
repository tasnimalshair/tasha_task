import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tasha_task/config/themes/color.dart';
import 'package:tasha_task/features/check_cubit.dart';
import 'package:tasha_task/shared/components.dart';
import 'package:flutter_bloc/src/bloc_consumer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PayMethodScreen extends StatelessWidget {
  const PayMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CheckBoxCubit>(
          create: (context) => CheckBoxCubit(),
        ),
      ],
      child: BlocConsumer<CheckBoxCubit, CheckState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context: context, appBarTitle: 'طريقة الدفع'),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'قم باختيار طريقة الدفع',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 80.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.2),
                              width: 1.5.w)),
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/png/bank.png',
                          width: 40.w,
                          height: 40.h,
                        ),
                        title: Text(
                          'Bank Of Palestine',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        trailing: Radio<String>(
                            activeColor: Colors.amber,
                            value: 'bank',
                            groupValue:
                                CheckBoxCubit.get(context).selectedRadio,
                            onChanged: (value) {
                              CheckBoxCubit.get(context).changeRadio(value);
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 80.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.2),
                              width: 1.5.w)),
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/png/jawwal.png',
                          width: 40.w,
                          height: 40.h,
                        ),
                        title: Text(
                          'Jawwal pay',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        trailing: Radio<String>(
                            activeColor: Colors.amber,
                            value: 'jawwal',
                            groupValue:
                                CheckBoxCubit.get(context).selectedRadio,
                            onChanged: (value) {
                              CheckBoxCubit.get(context).changeRadio(value);
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 21.h,
                    ),
                    Text(
                      'تفاصيل الحجز',
                      style: TextStyle(
                          fontSize: 17.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 17.h,
                    ),
                    Text(
                      'حجز',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'بداية الحجز',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'نهاية الحجز',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(children: [
                      Text(
                        'اجمالي المبلغ',
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Row(
                        textBaseline: TextBaseline.alphabetic,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          Text(
                            '200',
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: HexColor('#65B95C')),
                          ),
                          FaIcon(
                            FontAwesomeIcons.shekelSign,
                            size: 15,
                            color: HexColor('#65B95C'),
                          )
                        ],
                      )
                    ]),
                    SizedBox(height: 68.h),
                    mainButton(
                        text: 'استمرار',
                        onPressed: () {},
                        backgroundColor: defaultColor,
                        textColor: Colors.white)
                  ]),
            ),
          );
        },
      ),
    );
  }
}
