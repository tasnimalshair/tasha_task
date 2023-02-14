import 'dart:ui';

import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:range_slider_flutter/range_slider_flutter.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:tasha_task/features/getPeriodsCubit.dart';
import 'package:tasha_task/features/getSectionsCubit.dart';
import 'package:tasha_task/features/getServicesCubit.dart';
import 'package:tasha_task/models/area_model.dart';
import 'package:tasha_task/models/period_mpdel.dart';
import 'package:tasha_task/screens/app_screen.dart';
import 'package:tasha_task/screens/services/specific_service/chalet_data.dart';
import 'package:tasha_task/screens/services/specific_service/hotel_data.dart';
import 'package:tasha_task/screens/services/specific_service/resturant_data.dart';
import 'package:tasha_task/services/cubit.dart';
import 'package:tasha_task/services/states.dart';
import 'package:tasha_task/shared/components.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_bloc/src/bloc_consumer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasha_task/shared/constants.dart';

import '../../features/change_slider_cubit.dart';

class ChaletsScreen extends StatefulWidget {
  final Map map;
  ChaletsScreen({Key? key, required this.map}) : super(key: key);

  @override
  State<ChaletsScreen> createState() => _ChaletsScreenState();
}

class _ChaletsScreenState extends State<ChaletsScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetServicesCubit>(
            create: (context) => GetServicesCubit()
              ..getServices(sectioId: widget.map['sectionId'], name: '')),
        BlocProvider<AppCubit>(create: (contextUp) => AppCubit()..getCountries()),
        BlocProvider<GetPeriodsCubit>(
            create: (context) => GetPeriodsCubit()..getPeriods()),
        BlocProvider<ChangeSliderCubit>(
          create: (context) => ChangeSliderCubit(),
        ),
      ],
      child: BlocBuilder<GetServicesCubit, GetServicesStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(
                color: Colors.black,
                context: context,
                appBarTitle: widget.map['title']),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  buildSearchbar(
                      onChanged: (value) {
                        GetServicesCubit.get(context).getServices(
                            sectioId: widget.map['sectionId'], name: value);
                      },
                      hintText: 'ابحث عن ${widget.map['title']}',
                      onTap: () => showModalBottomSheet(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                            context: context,
                            builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider<AppCubit>(
                                    create: (context) =>
                                        AppCubit()..getCountries()),
                                BlocProvider<GetPeriodsCubit>(
                                    create: (context) =>
                                        GetPeriodsCubit()..getPeriods()),
                                BlocProvider<ChangeSliderCubit>(
                                  create: (context) => ChangeSliderCubit(),
                                ),
                              ],
                              child: Container(
                                // height: 500.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'عرض حسب',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 20.h),

                                            if (state
                                                    is AppGetCountriesSuccessState ||
                                                state is AppChangeMenuItemState)
                                               Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                height: 50.h,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20, right: 20),
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: DropdownButton(
                                                      // isExpanded: true,
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 14),
                                                      items: AppCubit.get(
                                                              context)
                                                          .countries!
                                                          .map((AreaModel?
                                                                  item) =>
                                                              DropdownMenuItem(
                                                                child: Text(
                                                                    item!.name),
                                                                value: item.iD,
                                                              ))
                                                          .toList(),
                                                      value:
                                                          AppCubit.get(context)
                                                              .dropDownValue,
                                                      onChanged: (value) {
                                                        AppCubit.get(context)
                                                            .onChangeItem(
                                                                value);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              )
                                             ,

                                      SizedBox(height: 10.h),

                                            if (state
                                                    is GetPeriodsSuccessState ||
                                                state
                                                    is GetPeriodsChangeMenuItemState)
                                               Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                height: 50.h,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20, right: 20),
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: DropdownButton(
                                                      // isExpanded: true,
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 14),
                                                      items: GetPeriodsCubit
                                                              .get(context)
                                                          .periods!
                                                          .map((PeriodModel?
                                                                  item) =>
                                                              DropdownMenuItem(
                                                                child: Text(
                                                                    item!
                                                                        .name!),
                                                                value:
                                                                    item.name,
                                                              ))
                                                          .toList(),
                                                      value:
                                                          GetPeriodsCubit.get(
                                                                  context)
                                                              .dropDownValue,
                                                      onChanged: (value) {
                                                        GetPeriodsCubit.get(
                                                                context)
                                                            .onChangeItem(
                                                                value);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                             Container(
                                              height: 50.h,
                                            ),

                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      Text(
                                        'السعر',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                  Column(
                                          children: [
                                            SfRangeSlider(
                                              min: 20.0,
                                              max: 2000.0,
                                              values:
                                                  ChangeSliderCubit.get(context)
                                                      .sliderValue,
                                              // interval: 20,
                                              activeColor: Colors.amber,
                                              showTicks: false,
                                              showLabels: false,
                                              enableTooltip: true,
                                              minorTicksPerInterval: 1,
                                              onChanged: (value) =>
                                                  ChangeSliderCubit.get(context)
                                                      .changeSlider(value),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                                              child: Row(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Text('20',
                                                          style: TextStyle(
                                                              color: Colors.grey,
                                                              fontSize: 13.sp,
                                                              fontWeight: FontWeight.bold)),
                                                      SizedBox(width: 3.w),
                                                      FaIcon(
                                                        FontAwesomeIcons.shekelSign,
                                                        size: 13,
                                                        color: Colors.grey,
                                                      )
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  FaIcon(
                                                    FontAwesomeIcons.shekelSign,
                                                    size: 13,
                                                    color: Colors.grey,
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),

                                      SizedBox(height: 10.h),
                                      Text(
                                        'ترتيب حسب',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10.h),
                                      ChipList(
                                        shouldWrap: false,
                                        listOfChipNames: [
                                          'الأكثر تقييم',
                                          'الأكثر مشاهدة',
                                          'المنطقة الأقرب',
                                          'الخصومات والعروض'
                                        ],
                                        spacing: 20,
                                        activeBgColorList: [Colors.amber],
                                        inactiveBgColorList: [
                                          Colors.grey.shade200
                                        ],
                                        activeTextColorList: [Colors.white],
                                        inactiveTextColorList: [Colors.black],
                                        listOfChipIndicesCurrentlySeclected: [
                                          1
                                        ],
                                      ),
                                      SizedBox(height: 20.h),
                                      mainButton(
                                          text: 'عرض',
                                          onPressed: () {
                                            GetServicesCubit.get(context)
                                                .getServices(sectioId: widget.map['sectionId'],
                                            governorateID: AppCubit.get(context).dropDownValue,
                                            periodTypeID:GetPeriodsCubit.get(context).dropDownValue,
                                            priceFrom: ChangeSliderCubit.get(context).sliderValue.start,
                                            priceTo:ChangeSliderCubit.get(context).sliderValue.end);
                                          },
                                          backgroundColor: HexColor('#6259A8'),
                                          textColor: Colors.white)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )),
                  SizedBox(height: 30.h),
                  if (state is GetServicesSuccessState)
                    Expanded(
                      child: Container(
                        child: ListView.separated(
                            itemBuilder: (context, index) =>
                                buildHotelContainer(
                                  withPrice: widget.map['sectionId'] == 3
                                      ? false
                                      : true,
                                  onTap: (model) {
                                    if (widget.map['sectionId'] == 1) {
                                      navigate(
                                          context: context,
                                          widget: SpecificChalet(
                                            model: model,
                                          ));
                                    } else if (widget.map['sectionId'] == 2) {
                                      navigate(
                                          context: context,
                                          widget: SpecificHotel(
                                            model: model,
                                          ));
                                    } else {
                                      navigate(
                                          context: context,
                                          widget: SpecificResturant(
                                            model: model,
                                          ));
                                    }
                                  },
                                  model: GetServicesCubit.get(context)
                                      .servicesData![index],
                                ),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 12.h,
                                ),
                            itemCount: GetServicesCubit.get(context)
                                .servicesData!
                                .length),
                      ),
                    ),


                ],
              ),
            ),
          );
        },
      ),
    );
  }
}



// BlocConsumer<GetServicesCubit, GetServicesStates>(
// listener: (context, state) {},
// builder: (context, state) {
// return Scaffold(
// appBar: buildAppBar(
// color: Colors.black,
// context: context,
// appBarTitle: widget.map['title']),
// body: Padding(
// padding: const EdgeInsets.all(20.0),
// child: Column(
// children: [
// buildSearchbar(
// onChanged: (value) {
// GetServicesCubit.get(context).getServices(
// sectioId: widget.map['sectionId'], name: value);
// },
// hintText: 'ابحث عن ${widget.map['title']}',
// onTap: () => showModalBottomSheet(
// clipBehavior: Clip.antiAlias,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(15),
// topRight: Radius.circular(15))),
// context: context,
// builder: (context) => MultiBlocProvider(
// providers: [
// BlocProvider<AppCubit>(
// create: (context) =>
// AppCubit()..getCountries()),
// BlocProvider<GetPeriodsCubit>(
// create: (context) =>
// GetPeriodsCubit()..getPeriods()),
// BlocProvider<ChangeSliderCubit>(
// create: (context) => ChangeSliderCubit(),
// ),
// ],
// child: Container(
// // height: 500.h,
// decoration: BoxDecoration(
// color: Colors.white,
// ),
// child: Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 20, vertical: 30),
// child: Column(
// crossAxisAlignment:
// CrossAxisAlignment.start,
// children: [
// Text(
// 'عرض حسب',
// style: TextStyle(
// fontSize: 17,
// fontWeight: FontWeight.bold),
// ),
// SizedBox(height: 20.h),
// BlocConsumer<AppCubit, AppStates>(
// listener: (context, state) {},
// builder: (context, state) {
// if (state
// is AppGetCountriesSuccessState ||
// state is AppChangeMenuItemState)
// return Container(
// width: double.infinity,
// decoration: BoxDecoration(
// color: Colors.grey[200],
// borderRadius:
// BorderRadius.circular(10),
// ),
// height: 50.h,
// child: Padding(
// padding:
// const EdgeInsets.only(
// left: 20, right: 20),
// child:
// DropdownButtonHideUnderline(
// child: DropdownButton(
// // isExpanded: true,
// style: TextStyle(
// color: Colors.grey,
// fontSize: 14),
// items: AppCubit.get(
// context)
//     .countries!
//     .map((AreaModel?
// item) =>
// DropdownMenuItem(
// child: Text(
// item!.name),
// value: item.iD,
// ))
//     .toList(),
// value:
// AppCubit.get(context)
//     .dropDownValue,
// onChanged: (value) {
// AppCubit.get(context)
//     .onChangeItem(
// value);
// },
// ),
// ),
// ),
// );
// return Container(height: 50.h);
// }),
// SizedBox(height: 10.h),
// BlocConsumer<GetPeriodsCubit,
// GetPeriodsStates>(
// listener: (context, state) {},
// builder: (context, state) {
// if (state
// is GetPeriodsSuccessState ||
// state
// is GetPeriodsChangeMenuItemState)
// return Container(
// width: double.infinity,
// decoration: BoxDecoration(
// color: Colors.grey[200],
// borderRadius:
// BorderRadius.circular(10),
// ),
// height: 50.h,
// child: Padding(
// padding:
// const EdgeInsets.only(
// left: 20, right: 20),
// child:
// DropdownButtonHideUnderline(
// child: DropdownButton(
// // isExpanded: true,
// style: TextStyle(
// color: Colors.grey,
// fontSize: 14),
// items: GetPeriodsCubit
//     .get(context)
//     .periods!
//     .map((PeriodModel?
// item) =>
// DropdownMenuItem(
// child: Text(
// item!
//     .name!),
// value:
// item.name,
// ))
//     .toList(),
// value:
// GetPeriodsCubit.get(
// context)
//     .dropDownValue,
// onChanged: (value) {
// GetPeriodsCubit.get(
// context)
//     .onChangeItem(
// value);
// },
// ),
// ),
// ),
// );
// return Container(
// height: 50.h,
// );
// }),
// SizedBox(
// height: 16.h,
// ),
// Text(
// 'السعر',
// style: TextStyle(
// fontSize: 17,
// fontWeight: FontWeight.bold),
// ),
// SizedBox(
// height: 10.h,
// ),
// BlocConsumer<ChangeSliderCubit,
// SliderStates>(
// listener: (context, state) {},
// builder: (context, state) => Column(
// children: [
// SfRangeSlider(
// min: 20.0,
// max: 2000.0,
// values:
// ChangeSliderCubit.get(context)
//     .sliderValue,
// // interval: 20,
// activeColor: Colors.amber,
// showTicks: false,
// showLabels: false,
// enableTooltip: true,
// minorTicksPerInterval: 1,
// onChanged: (value) =>
// ChangeSliderCubit.get(context)
//     .changeSlider(value),
// ),
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
// child: Row(
// children: [
// Row(
// mainAxisAlignment:
// MainAxisAlignment.center,
// children: [
// Text('20',
// style: TextStyle(
// color: Colors.grey,
// fontSize: 13.sp,
// fontWeight: FontWeight.bold)),
// SizedBox(width: 3.w),
// FaIcon(
// FontAwesomeIcons.shekelSign,
// size: 13,
// color: Colors.grey,
// )
// ],
// ),
// Spacer(),
// FaIcon(
// FontAwesomeIcons.shekelSign,
// size: 13,
// color: Colors.grey,
// )
// ],
// ),
// )
// ],
// ),
// ),
// SizedBox(height: 10.h),
// Text(
// 'ترتيب حسب',
// style: TextStyle(
// fontSize: 17,
// fontWeight: FontWeight.bold),
// ),
// SizedBox(height: 10.h),
// ChipList(
// shouldWrap: false,
// listOfChipNames: [
// 'الأكثر تقييم',
// 'الأكثر مشاهدة',
// 'المنطقة الأقرب',
// 'الخصومات والعروض'
// ],
// spacing: 20,
// activeBgColorList: [Colors.amber],
// inactiveBgColorList: [
// Colors.grey.shade200
// ],
// activeTextColorList: [Colors.white],
// inactiveTextColorList: [Colors.black],
// listOfChipIndicesCurrentlySeclected: [
// 1
// ],
// ),
// SizedBox(height: 20.h),
// mainButton(
// text: 'عرض',
// onPressed: () {
// GetServicesCubit.get(context)
//     .getServices(sectioId: widget.map['sectionId'],
// governorateID: AppCubit.get(context).dropDownValue,
// periodTypeID:GetPeriodsCubit.get(context).dropDownValue,
// priceFrom: ChangeSliderCubit.get(context).sliderValue.start,
// priceTo:ChangeSliderCubit.get(context).sliderValue.end);
// },
// backgroundColor: HexColor('#6259A8'),
// textColor: Colors.white)
// ],
// ),
// ),
// ),
// ),
// )),
// SizedBox(height: 30.h),
// if (state is GetServicesSuccessState)
// Expanded(
// child: Container(
// child: ListView.separated(
// itemBuilder: (context, index) =>
// buildHotelContainer(
// withPrice: widget.map['sectionId'] == 3
// ? false
//     : true,
// onTap: (model) {
// if (widget.map['sectionId'] == 1) {
// navigate(
// context: context,
// widget: SpecificChalet(
// model: model,
// ));
// } else if (widget.map['sectionId'] == 2) {
// navigate(
// context: context,
// widget: SpecificHotel(
// model: model,
// ));
// } else {
// navigate(
// context: context,
// widget: SpecificResturant(
// model: model,
// ));
// }
// },
// model: GetServicesCubit.get(context)
//     .servicesData![index],
// ),
// separatorBuilder: (context, index) => SizedBox(
// height: 12.h,
// ),
// itemCount: GetServicesCubit.get(context)
//     .servicesData!
//     .length),
// ),
// ),
//
//
// ],
// ),
// ),
// );
// },
// ),