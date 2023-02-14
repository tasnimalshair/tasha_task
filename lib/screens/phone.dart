import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:tasha_task/services/cubit.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasha_task/services/states.dart';


class PhoneScreen extends StatefulWidget {
  PhoneScreen({Key? key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenOtp();
  }

  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  // late TextEditingController phoneController;
  //
  // String _comingSms = 'Unknown';
  //
  // Future<void> initSmsListener() async {
  //
  //   String comingSms;
  //   try {
  //     // comingSms = await AltSmsAutofill().listenForSms;
  //   } on PlatformException {
  //     comingSms = 'Failed to get Sms.';
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     // _comingSms = comingSms;
  //     print("====>Message: ${_comingSms}");
  //     print("${_comingSms[32]}");
  //     phoneController.text = _comingSms[32] + _comingSms[33] + _comingSms[34] + _comingSms[35]
  //         + _comingSms[36] + _comingSms[37]; //used to set the code in the message to a string and setting it to a textcontroller. message length is 38. so my code is in string index 32-37.
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppConfirmSuccessState) {
          Logger().e('IN PHONE LISTENER');
          Logger().e(AppCubit.get(context).registerData['userName']);
          AppCubit.get(context).Login(
              context: context,
              username: AppCubit.get(context).registerData['userName'],
              password: AppCubit.get(context).registerData['password']);
          // if(state is )
          // navigateWithReplacement(context: context, widget: AppScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //   child: SvgPicture.asset('assets/images/svg/phone.svg',
                      //       height: 70, width: 70, allowDrawingOutsideViewBox: true),
                      // ),
                      Image.asset(
                        'assets/images/png/phone2.png',
                        width: double.infinity,
                      ),
                      Text(
                        'تأكيد رقم الهاتف',
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 9.8.h),
                      Text(
                          'لقد أرسلنا كود تفعيلي  من 5 ارقام على\n رقم الهاتف الخاص بك',
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.w400)),
                      SizedBox(height: 45.h),

                      // PinCodeTextField(
                      //   controller: phoneController,
                      //
                      //   length: 5,
                      //   obscureText: false,
                      //   // animationType: AnimationType.fade,
                      //   pinTheme: PinTheme(
                      //     inactiveFillColor: Colors.grey[200],
                      //     shape: PinCodeFieldShape.box,
                      //     borderWidth: 0.w,
                      //     inactiveColor: Colors.grey,
                      //     activeColor: HexColor('#6259A8'),
                      //     borderRadius: BorderRadius.circular(5),
                      //     fieldHeight: 48.h,
                      //     fieldWidth: 53.w,
                      //     activeFillColor: Colors.white,
                      //   ),
                      //   // animationDuration: Duration(milliseconds: 300),
                      //   // backgroundColor: Colors.blue.shade50,
                      //   enableActiveFill: true,
                      //   // errorAnimationController: errorController,
                      //   // controller: textEditingController,
                      //   onCompleted: (v) {
                      //     print("Completed");
                      //   },
                      //   onChanged: (value) {},
                      //   beforeTextPaste: (text) {
                      //     print("Allowing to paste $text");
                      //
                      //     return true;
                      //   },
                      //   appContext: context,
                      // ),
                      PinFieldAutoFill(
                        codeLength: 5,
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        width: double.infinity,
                        height: 44.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: MaterialButton(
                          color: HexColor('#6259A8'),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Logger().e(AppCubit.get(context).registerData['ID']);
                              Logger().e(AppCubit.get(context).registerData);
                              Logger().e(AppCubit.get(context).hashCode);

                              AppCubit.get(context).confirmMobile(
                                  id:
                                      AppCubit.get(context).registerData['ID'],
                                  confirmationCode: AppCubit.get(context)
                                      .registerData['ConfirmationCode']);
                              // request to confirm then if success in listener do login request

                              // if (phoneController.text == widget.registerModel!.data![0].msgTxt!.substring(0,5)) {
                              //   Navigator.pushReplacement(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) => AppScreen(),
                              //       ));
                              // }

                              // AppCubit.get(context).register(
                              //     addressDetails: AppCubit.get(context).dropDownValue,
                              //     addressID: AppCubit.get(context).registerData['addressID'],
                              //     birthDate: AppCubit.get(context).registerData['birthDate'],
                              //     bUserName: AppCubit.get(context).registerData['bUserName'],
                              //     firstName: AppCubit.get(context).registerData['firstName'],
                              //     gender: AppCubit.get(context).registerData['gender'],
                              //     idno: AppCubit.get(context).registerData['idno'],
                              //     lastName: AppCubit.get(context).registerData['lastName'],
                              //     mobileNumber: AppCubit.get(context).registerData['mobileNumber'],
                              //     password: AppCubit.get(context).registerData['password']);
                            }
                          },
                          child: Text(
                            'تأكيد رقم الهاتف',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void listenOtp() async {
    await SmsAutoFill().listenForCode;
  }
}
// https://www.youtube.com/watch?v=l_DqmTQ5dHQ
