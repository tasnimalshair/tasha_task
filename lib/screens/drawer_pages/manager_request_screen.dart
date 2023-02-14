import 'dart:ui';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tasha_task/features/getSectionsCubit.dart';
import 'package:tasha_task/features/get_manager_request_cubit.dart';
import 'package:tasha_task/models/area_model.dart';
import 'package:tasha_task/models/section_model.dart';
import 'package:tasha_task/services/cubit.dart';
import 'package:tasha_task/services/states.dart';
import 'package:tasha_task/shared/components.dart';
import 'package:flutter_bloc/src/bloc_consumer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagerRequestScreen extends StatelessWidget {
  ManagerRequestScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var notesController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  var sectionIdSelected;
  var addressIdSelected;

  @override
  Widget build(BuildContext context) {
    // ToastContext.init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetSectionsCubit>(
          create: (context) => GetSectionsCubit()..getSections(),
        ),
        BlocProvider<GetManagerRequestCubit>(
          create: (context) => GetManagerRequestCubit(),
        ),
        BlocProvider<AppCubit>(
          create: (context) => AppCubit()..getCountries(),
        ),
      ],
      child: Form(
        key: formKey,
        child: Scaffold(
          appBar: buildAppBar(
            // color: Colors.black,
            context: context,
            appBarTitle: 'طلب اضافة منشأة',
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تقديم طلب الحصول على صاحب منشأة',
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#6259A8')),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  BlocConsumer<GetSectionsCubit, GetSectionsStates>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is GetSectionsSuccessState ||
                          state is ChangeMenuItemState)
                        return Container(
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
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                                items: GetSectionsCubit.get(context)
                                    .sections!
                                    .map((SectionModel? item) =>
                                        DropdownMenuItem(
                                          child: Text(item!.title!),
                                          value: item.iD,
                                        ))
                                    .toList(),
                                value:
                                    GetSectionsCubit.get(context).dropDownValue,
                                onChanged: (value) {
                                  GetSectionsCubit.get(context)
                                      .onChangeItem(value);
                                },
                              ),
                            ),
                          ),
                        );
                      return Container();
                    },
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  BlocConsumer<AppCubit, AppStates>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is AppGetCountriesSuccessState ||
                          state is AppChangeMenuItemState)
                        return Container(
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
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                                items: AppCubit.get(context)
                                    .countries!
                                    .map((AreaModel? item) => DropdownMenuItem(
                                          child: Text(item!.name),
                                          value: item.iD,
                                        ))
                                    .toList(),
                                value: AppCubit.get(context).dropDownValue,
                                onChanged: (value) {
                                  AppCubit.get(context).onChangeItem(value);
                                },
                              ),
                            ),
                          ),
                        );
                      return Container();
                    },
                  ),
                  SizedBox(height: 12.h),
                  mainTextField(
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'اسم المنشأة مطلوب';
                        }
                        return null;
                      },
                      text: 'اسم المنشأة',
                      keyboardType: TextInputType.text),
                  SizedBox(height: 12.h),
                  mainTextField(
                      controller: addressController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'العنوان مطلوب';
                        }
                        return null;
                      },
                      text: 'العنوان بالتفصيل',
                      keyboardType: TextInputType.text),
                  SizedBox(height: 12.h),
                  mainTextField(
                    controller: notesController,
                    minLines: 7,
                    maxLines: 8,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return null;
                      }
                      return null;
                    },
                    text: 'ملاحظات أخرى',
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: 56.h),
                  BlocConsumer<GetManagerRequestCubit, GetManagerRequestStates>(
                    listener: (context, state) {
                      if (state is GetManagerReqestSuccessState)

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(state.model!.msg!,textAlign: TextAlign.center),
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight:
                            Radius.circular(10)),
                          ),
                        ));
                    },
                    builder: (context, state) {
                      return ConditionalBuilder(
                        condition: state is! GetManagerRequestLoadingState,
                        fallback: (context) => Center(child: CircularProgressIndicator()),
                        builder: (context) =>  mainButton(
                            text: 'إرسال',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                GetManagerRequestCubit.get(context)
                                    .getManagerRequest(
                                    addressDetails: addressController.text,
                                    addressID:
                                    AppCubit.get(context).dropDownValue,
                                    name: nameController.text,
                                    sectionType: GetSectionsCubit.get(context)
                                        .dropDownValue,
                                    notes: notesController.text);
                              }
                            },
                            backgroundColor: HexColor('#6259A8'),
                            textColor: Colors.white),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
