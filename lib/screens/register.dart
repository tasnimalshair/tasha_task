import 'dart:math';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:tasha_task/features/check_cubit.dart';
import 'package:tasha_task/models/area_model.dart';
import 'package:tasha_task/screens/login_screen.dart';
import 'package:tasha_task/screens/phone.dart';
import 'package:tasha_task/services/cubit.dart';
import 'package:tasha_task/services/states.dart';
import 'package:tasha_task/shared/components.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/src/bloc_consumer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  var fnameController = TextEditingController();
  var lnameController = TextEditingController();
  var fname = TextEditingController();
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var phoneController = TextEditingController();
  var usernameController = TextEditingController();
  var genderController = TextEditingController();
  var bdController = TextEditingController();
  var passwordController = TextEditingController();
  var idNoController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  var finalRadio;

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CheckBoxCubit>(
      create: (context) => CheckBoxCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) async {
          if (state is AppRegisterSuccessState) {
            final signCode = await SmsAutoFill().getAppSignature;
            print(signCode);
            print(state.model.data?[0].msgTxt);

            Logger().e(state.model.data![0].fCMToken);


            AppCubit.get(context).addRegisterData(
                id: state.model.rv!,
                confirmCode: state.model.data![0].msgTxt!.substring(24),
                username: usernameController.text,
                password: passwordController.text);
            navigateWithReplacement(context: context, widget: PhoneScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
                iconTheme: IconThemeData(
              color: Colors.black,
            )),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'مستخدم جديد',
                        style: TextStyle(fontSize: 20.sp),
                      ),
                      SizedBox(height: 9.8.h),
                      Text('قم بتسجيل الدخول كمستخدم جديد',
                          style: TextStyle(fontSize: 16.sp)),
                      SizedBox(height: 22.5.h),
                      Row(children: [
                        Expanded(
                          child: mainTextField(
                              controller: fnameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'الإسم الأول مطلوب';
                                }
                                return null;
                              },
                              text: 'الإسم الأول',
                              keyboardType: TextInputType.text),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: mainTextField(
                              controller: lnameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'الإسم الأخير مطلوب';
                                }
                                return null;
                              },
                              text: 'الإسم الأخير',
                              keyboardType: TextInputType.text),
                        ),
                      ]),
                      SizedBox(height: 10.h),
                      mainTextField(
                          controller: addressController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'العنوان مطلوب';
                            }
                            return null;
                          },
                          text: 'العنوان',
                          keyboardType: TextInputType.text),
                      SizedBox(height: 10.h),
                      if (state is AppGetCountriesSuccessState ||
                          state is AppChangeMenuItemState)
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: 50.h,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                style: TextStyle(
                                    fontFamily: 'Almarai',
                                    color: Colors.grey,
                                    fontSize: 14),
                                items: AppCubit.get(context)
                                    .countries!
                                    .map((AreaModel? item) => DropdownMenuItem(
                                          child: Text(item!.name),
                                          value: item.name,
                                        ))
                                    .toList(),
                                value: AppCubit.get(context).dropDownValue,
                                onChanged: (value) {
                                  AppCubit.get(context).onChangeItem(value);
                                },
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: 10.h),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        height: 50.h,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 16),
                          child: InternationalPhoneNumberInput(
                            inputDecoration: InputDecoration(
                                hintText: 'رقم الهاتف',
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 14.sp),
                                enabledBorder: InputBorder.none),
                            onInputChanged: (PhoneNumber number) {
                              print(number.phoneNumber);
                            },
                            onInputValidated: (bool value) {
                              print(value);
                            },
                            selectorConfig: SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            ),
                            ignoreBlank: false,
                            autoValidateMode: AutovalidateMode.disabled,
                            selectorTextStyle: TextStyle(color: Colors.black),
                            textFieldController: phoneController,
                            formatInput: false,
                            keyboardType: TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            inputBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    width: 0.w, style: BorderStyle.none)),
                            onSaved: (PhoneNumber number) {
                              print('On Saved: $number');
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      mainTextField(
                          controller: usernameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'اسم المستخدم مطلوب';
                            }
                            return null;
                          },
                          text: 'اسم المستخدم',
                          keyboardType: TextInputType.text),
                      SizedBox(height: 3.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(
                                'ذكر',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                              leading: BlocConsumer<CheckBoxCubit, CheckState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  return Radio<String>(
                                      value:
                                          'mail',
                                      groupValue: CheckBoxCubit.get(context)
                                          .selectedRadio,
                                      onChanged: (value) {
                                        CheckBoxCubit.get(context)
                                            .changeRadio(value);
                                        finalRadio = 1;
                                      });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                              child: ListTile(
                                  title: Text(
                                    'أنثى',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                  leading:
                                      BlocConsumer<CheckBoxCubit, CheckState>(
                                    listener: (context, state) {},
                                    builder: (context, state) {
                                      return Radio<String>(
                                          value: 'female',
                                          groupValue: CheckBoxCubit.get(context)
                                              .selectedRadio,
                                          onChanged: (value) {
                                            CheckBoxCubit.get(context)
                                                .changeRadio(value);
                                            finalRadio = 2;
                                          });
                                    },
                                  ))),
                        ],
                      ),
                      // FormBuilderRadioGroup(
                      //   // decoration: InputDecoration(labelText: 'My best language'),
                      //   name: 'gender',
                      //   validator: FormBuilderValidators.required(),
                      //   options: ['ذكر', 'أنثى']
                      //       .map((gender) => FormBuilderFieldOption(
                      //             value: gender,
                      //             child: Text(gender),
                      //           ))
                      //       .toList(growable: false),
                      //   onChanged: (value) {
                      //     // AppCubit.get(context).changeRadio(value);
                      //     finalRadio = value == 'ذكر' ? 1 : 2;
                      //   },
                      // ),

                      // mainTextField(
                      //     controller: genderController,
                      //     validator: (value) {
                      //       if (value!.isEmpty) {
                      //         return 'الجنس مطلوب';
                      //       }
                      //       return null;
                      //     },
                      //     text: 'الجنس',
                      //     keyboardType: TextInputType.text),
                      SizedBox(height: 3.h),
                      mainTextField(
                          onTap: () async {
                            print('ddddddddddddddd');
                            DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.parse('1900-08-01'),
                                lastDate: DateTime.parse('2022-12-01'));
                            if (date != null) {
                              bdController.text = '1967-04-18';
                              // bdController.text=DateFormat('yyyy-mm-dd').format(date);
                            }
                          },
                          controller: bdController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'تاريخ الميلاد مطلوب';
                            }
                            return null;
                          },
                          text: 'تاريخ الميلاد',
                          keyboardType: TextInputType.datetime),
                      SizedBox(height: 10.h),
                      mainTextField(
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'كلمة المرور مطلوب';
                            }
                            return null;
                          },
                          text: 'كلمة المرور',
                          keyboardType: TextInputType.visiblePassword),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          BlocConsumer<CheckBoxCubit, CheckState>(
                            listener: (context, state) {
                              isChecked =
                                  CheckBoxCubit.get(context).checkValue == true
                                      ? true
                                      : false;
                            },
                            builder: (context, state) {
                              return Checkbox(
                                value: CheckBoxCubit.get(context).checkValue,
                                onChanged: (value) => CheckBoxCubit.get(context)
                                    .ChangeCheckValue(value),
                              );
                            },
                          ),
                          Text('الموافقة على'),
                          TextButton(
                              onPressed: () {},
                              child: Text('شروط الخصوصية',
                                  style: TextStyle(color: HexColor('#6259A8'))))
                        ],
                      ),
                      SizedBox(height: 23.h),
                      mainButton(
                          text: 'تسجيل',
                          onPressed: () {
                            if (formKey.currentState!.validate() &&
                                isChecked == true) {
                              AppCubit.get(context).register(
                                  addressDetails:
                                      AppCubit.get(context).dropDownValue,
                                  addressID: addressController.text,
                                  birthDate: bdController.text,
                                  bUserName: usernameController.text,
                                  firstName: fnameController.text,
                                  gender: finalRadio,
                                  idno: Random().nextInt(9999).toString(),
                                  lastName: lnameController.text,
                                  mobileNumber: phoneController.text,
                                  password: passwordController.text);

                              // AppCubit.get(context).addRegisterData(
                              //     addressDetails:
                              //         AppCubit.get(context).dropDownValue,
                              //     addressID: addressController.text,
                              //     birthDate: bdController.text,
                              //     bUserName: usernameController.text,
                              //     firstName: fnameController.text,
                              //     gender: genderController.text,
                              //     idno: idNoController.text,
                              //     lastName: lnameController.text,
                              //     mobileNumber: phoneController.text,
                              //     password: passwordController.text);
                            }
                          },
                          backgroundColor: HexColor('#6259A8'),
                          textColor: Colors.white),
                      SizedBox(
                        height: 28.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'لدي حساب!',
                            style: TextStyle(fontSize: 15.sp),
                          ),
                          TextButton(
                              onPressed: () => navigateWithReplacement(
                                  context: context, widget: LoginScreen()),
                              child: Text('تسجيل الدخول',
                                  style: TextStyle(color: HexColor('#6259A8'))))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
