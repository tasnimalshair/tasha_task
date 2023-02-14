import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:tasha_task/data/local/cashe_helper.dart';
import 'package:tasha_task/screens/app_screen.dart';
import 'package:tasha_task/services/cubit.dart';
import 'package:tasha_task/services/states.dart';
import 'package:tasha_task/screens/register.dart';
import 'package:tasha_task/shared/components.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) async {
          if (state is AppSuccessState) {
            Logger().e(state.model.token);
            if (state.model.rv == 1) {
              bool saved =
                  await CashHelper.saveData(key: CashHelper.token, value: true);
            }
          }
          // if(state is AppLoginFbSuccessState ||state is AppLoginGmailSuccessState){
          //   navigateWithReplacement(context: context, widget: AppScreen());
          // }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/png/tasha.png'),
                      SizedBox(height: 80.h),
                      Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 24.h),
                      mainTextField(
                          controller: usernameController,
                          validator: (value) {
                            if (usernameController.text.isEmpty) {
                              return 'اسم المستخدم مطلوب';
                            }
                            return null;
                          },
                          text: 'اسم المستخدم',
                          keyboardType: TextInputType.text),
                      SizedBox(height: 12.h),
                      mainTextField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          validator: (value) {
                            if (passwordController.text.isEmpty) {
                              return 'كلمة المرور مطلوبة';
                            }
                            return null;
                          },
                          text: 'كلمة المرور'),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'هل نسيت كلمة المرور؟',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w300),
                            )),
                      ),
                      SizedBox(height: 10.h),
                      ConditionalBuilder(
                        condition: state is! AppLoadingState,
                        fallback: (context) => CircularProgressIndicator(),
                        builder: (context) => mainButton(
                            textColor: Colors.white,
                            backgroundColor: HexColor('#6259A8'),
                            text: 'دخول',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                AppCubit.get(context).Login(
                                    context: context,
                                    username: usernameController.text,
                                    password: passwordController.text);
                              }
                              return null;
                            }),
                      ),
                      SizedBox(height: 10.h),
                      mainButton(
                          textColor: HexColor('#6259A8'),
                          borderColor: HexColor('#6259A8'),
                          backgroundColor: Colors.white,
                          text: 'الدخول كزائر',
                          onPressed: () {}),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              final GoogleSignInAccount? googleUser =
                                  await GoogleSignIn().signIn();

                              // Obtain the auth details from the request
                              final GoogleSignInAuthentication? googleAuth =
                                  await googleUser?.authentication;
                              print('USER ID = ${googleUser!.id}');
                              print('id token ${googleAuth!.idToken}');
                              AppCubit.get(context).loginWithGmail(
                                  idToken: '${googleAuth.idToken}');
                            },
                            child: Container(
                              height: 45.h,
                              width: 45.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Card(
                                child:
                                    Image.asset('assets/images/png/gmail.png'),
                                elevation: 2,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              final LoginResult loginResult =
                                  await FacebookAuth.instance.login();
                              print(
                                  'Id ${loginResult.accessToken?.applicationId}');
                              print(
                                  'token = ${loginResult.accessToken?.token}');
                              AppCubit.get(context).loginWithFb(
                                  accessToken: '${loginResult.accessToken}');
                            },
                            child: Container(
                              height: 45.h,
                              width: 45.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Card(
                                child: Image.asset('assets/images/png/fb.png'),
                                elevation: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 34.h),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ليس لديك حساب؟',
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterScreen(),
                                      ));
                                },
                                child: Text('انشاء حساب ',
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: HexColor('#6259A8'))))
                          ]),
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
