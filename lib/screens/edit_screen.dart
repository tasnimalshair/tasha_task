import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:tasha_task/config/themes/color.dart';
import 'package:tasha_task/features/edit_data_cubit.dart';
import 'package:tasha_task/shared/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditScreen extends StatelessWidget {
  EditScreen({Key? key}) : super(key: key);

  var fNameController = TextEditingController(text: 'zain');
  var lNameController = TextEditingController(text: 'asi');
  var addressController = TextEditingController(text: 'غزة');
  var mobileController = TextEditingController(text: '0592421686');
  var bdController = TextEditingController(text: '29/3/2002');

  var keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditDataCubit>(
        create: (context) => EditDataCubit(),
        child: BlocConsumer<EditDataCubit, EditDataStates>(
            listener: (context, state) {
          if (state is EditDataSuccessState) Logger().e('YESSSSSSSSSSSSSSS');
        }, builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(
                context: context, appBarTitle: 'تعديل الملف الشخصي'),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    key: keyForm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                    alignment: Alignment.centerRight,
                                    child: Text('الإسم الأول')),
                                SizedBox(height: 8.h),
                                mainTextField(
                                    style: TextStyle(fontSize: 13.sp),
                                    controller: fNameController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'الإسم الأول مطلوب';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.text),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Column(
                                children: [
                                  Container(
                                      alignment: Alignment.centerRight,
                                      child: Text('الإسم الأخير')),
                                  SizedBox(height: 8.h),
                                  mainTextField(
                                      style: TextStyle(fontSize: 13.sp),
                                      controller: lNameController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'الإسم الأخير مطلوب';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.text),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Text('العنوان بالتفصيل'),
                      SizedBox(height: 8.h),
                      mainTextField(
                          style: TextStyle(fontSize: 13.sp),
                          controller: addressController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' العنوان مطلوب';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text),
                      SizedBox(height: 20.h),
                      Text('رقم الموبايل'),
                      SizedBox(height: 8.h),
                      mainTextField(
                          style: TextStyle(fontSize: 13.sp),
                          controller: mobileController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'رقم الموبايل مطلوب';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone),
                      SizedBox(height: 20.h),
                      Text('تاريخ الميلاد'),
                      SizedBox(height: 8.h),
                      mainTextField(
                          style: TextStyle(fontSize: 13.sp),
                          onTap: () async {
                            // print('ddddddddddddddd');
                            DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.parse('1900-08-01'),
                                lastDate: DateTime.parse('2022-12-01'));
                            if (date != null) {
                              // bdController.text = '1967-04-18';
                              bdController.text =
                                  DateFormat('yyyy-mm-dd').format(date);
                            }
                          },
                          controller: bdController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'تاريخ الميلاد مطلوب';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.datetime),
                      SizedBox(height: 50.h),
                      mainButton(
                          text: 'تعديل',
                          onPressed: () {
                            if (keyForm.currentState!.validate()) {
                              EditDataCubit.get(context).editData(
                                  FirstName: fNameController.text,
                                  LastName: lNameController.text,
                                  AddressDetails: addressController.text,
                                  MobileNumber: mobileController.text,
                                  BirthDate: bdController.text);
                            }
                          },
                          backgroundColor: defaultColor,
                          textColor: Colors.white)
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
