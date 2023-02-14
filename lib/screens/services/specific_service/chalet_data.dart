import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tasha_task/features/check_cubit.dart';
import 'package:tasha_task/features/getMenusCubit.dart';
import 'package:tasha_task/features/getPeriodsCubit.dart';
import 'package:tasha_task/features/get_entertainment_services_cubit.dart';
import 'package:tasha_task/features/get_section_prices_cubit.dart';
import 'package:tasha_task/models/services_model.dart';
import 'package:tasha_task/screens/maps._screen.dart';
import 'dart:async';
import 'package:tasha_task/services/cubit.dart';
import 'package:tasha_task/services/states.dart';
import 'package:flutter_bloc/src/bloc_consumer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasha_task/shared/components.dart';
import 'package:chip_list/chip_list.dart';
import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../config/themes/color.dart';



class SpecificChalet extends StatefulWidget {
  final ServiceData model;
  const SpecificChalet({Key? key, required this.model}) : super(key: key);

  @override
  State<SpecificChalet> createState() => _SpecificChaletState();
}

class _SpecificChaletState extends State<SpecificChalet> {
  int _currentPage = 0;

  PageController? pageController = PageController(initialPage: 0);

  bool end = false;
  DateRangePickerController fController=DateRangePickerController();
  DateRangePickerController sController=DateRangePickerController();
  DateRangePickerController tController=DateRangePickerController();


  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_currentPage == 3) {
        end = true;
      } else if (_currentPage == 0) {
        end = false;
      }

      if (end == false) {
        _currentPage++;
      } else {
        _currentPage--;
      }
      if (pageController!.hasClients) {
        pageController!.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 1000),
          curve: Curves.easeIn,
        );
      }
    });
  }

  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (context) => AppCubit(),
        ),
        BlocProvider<GetPeriodsCubit>(
          create: (context) => GetPeriodsCubit()..getPeriods(),
        ),
        BlocProvider<GetEntertainmentsServicesCubit>(
          create: (context) => GetEntertainmentsServicesCubit()
            ..getEntertainmentsServices(
                sectionID: widget.model.iD!,
                SectionTypeID: widget.model.sectionType!),
        ),
      ],
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showCustomDateRangePicker(
                context,
                dismissible: true,
                minimumDate: DateTime.now(),
                maximumDate: DateTime.now().add(const Duration(days: 30)),
                endDate: startDate,
                startDate: startDate,
                onApplyClick: (start, end) {
                  setState(() {
                    endDate = end;
                    startDate = start;
                  });
                },
                onCancelClick: () {
                  setState(() {
                    endDate = null;
                    startDate = null;
                  });
                },
              );
            },
            tooltip: 'choose date Range',
            child:
                const Icon(Icons.calendar_today_outlined, color: Colors.white),
          ),
          backgroundColor: Colors.grey[100],
          extendBodyBehindAppBar: true,
          appBar: buildAppBar(
              // onPressed: () => Navigator.pop(context),
              color: Colors.white,
              context: context,
              appBarTitle: widget.model.name!,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.share,
                            color: HexColor('#6259A8'),
                          ))),
                )
              ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    // overflow: Overflow.visible,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 290.h,
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            // if (state is GetAdvertisementsSuccessState)
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: PageView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => Container(
                                    clipBehavior: Clip.antiAlias,
                                    height: 290.h,
                                    child: mainCachedImage(
                                      url: widget.model.pictures!.length > 0
                                          ? 'http://tasha.accessline.ps//Files/${widget.model.pictures?[index].fileName}'
                                          : '',
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    )),
                                itemCount: widget.model.pictures!.length,
                                controller: pageController,
                              ),
                            ),
                            // if (state is GetAdvertisementsSuccessState)
                            Positioned(
                                bottom: 10.h,
                                child: SmoothPageIndicator(
                                  controller: pageController!,
                                  count: widget.model.pictures!.length,
                                  axisDirection: Axis.horizontal,
                                  effect: SlideEffect(
                                      spacing: 8.0,
                                      radius: 10.0,
                                      dotWidth: 10.0,
                                      dotHeight: 10.0,
                                      strokeWidth: 1.5,
                                      dotColor: Colors.white.withOpacity(0.5),
                                      activeDotColor: Colors.white),
                                )),
                          ],
                        ),
                      ),
                      BlocConsumer<AppCubit, AppStates>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return Positioned(
                            bottom: -20,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                    onPressed: () {
                                      AppCubit.get(context).changeFav();
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      color: AppCubit.get(context).isFav == true
                                          ? Colors.red
                                          : Colors.grey,
                                    )),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  widget.model.name!,
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: HexColor('#6259A8')),
                                ),
                                SizedBox(height: 10),
                                RatingBar.builder(
                                  ignoreGestures: true,
                                  unratedColor: Colors.grey[400],
                                  itemSize: 20,
                                  initialRating:
                                      (widget.model.rate)!.toDouble(),
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: EdgeInsets.only(left: 6),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ],
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15))),
                                    context: context,
                                    builder: (context) =>
                                        BlocProvider<GetSectionPricesCubit>(
                                          create: (context) =>
                                              GetSectionPricesCubit()
                                                ..getSectionPrices(
                                                    sectionID:
                                                        widget.model.iD!),
                                          child: BlocConsumer<
                                              GetSectionPricesCubit,
                                              GetSectionPricesStates>(
                                            listener: (context, state) {},
                                            builder: (context, state) =>
                                                Container(
                                              height: 448.h,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'الأسعار الخاصة بالشاليه',
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 14.h),
                                                    if (state
                                                        is GetSectionPricesLoadingState)
                                                      Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                    if (state
                                                        is GetSectionPricesSuccessState)
                                                      Expanded(
                                                        child: GetSectionPricesCubit
                                                                        .get(
                                                                            context)
                                                                    .sectionPrices!
                                                                    .length >
                                                                0
                                                            ? ListView
                                                                .separated(
                                                                    itemBuilder:
                                                                        (context,
                                                                                index) =>
                                                                            Padding(
                                                                              padding: const EdgeInsets.symmetric(vertical: 10),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text(
                                                                                    GetSectionPricesCubit.get(context).sectionPrices![index].bookingName!,
                                                                                    style: TextStyle(fontSize: 15.sp),
                                                                                  ),
                                                                                  Text(
                                                                                    '${GetSectionPricesCubit.get(context).sectionPrices![index].price!} ${GetSectionPricesCubit.get(context).sectionPrices![index].currency!} -${GetSectionPricesCubit.get(context).sectionPrices![index].periodTypeName!}',
                                                                                    style: TextStyle(fontSize: 16.sp, color: HexColor('#6259A8'), fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                    separatorBuilder:
                                                                        (context,
                                                                                index) =>
                                                                            Divider(
                                                                              thickness: 1.5,
                                                                            ),
                                                                    itemCount: GetSectionPricesCubit.get(
                                                                            context)
                                                                        .sectionPrices!
                                                                        .length)
                                                            : Center(
                                                                child: Text(
                                                                  'لا تتوفر أسعار لهذا الشاليه',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                ),
                                                              ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ));
                              },
                              child: Container(
                                height: 62.h,
                                width: 70.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('${widget.model.defaultPrice}',
                                            style: TextStyle(
                                                color: HexColor('#65B95C'),
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(width: 3.w),
                                        FaIcon(
                                          FontAwesomeIcons.shekelSign,
                                          size: 15,
                                          color: HexColor('#65B95C'),
                                        )
                                      ],
                                    ),
                                    Text(
                                      'تصفح الأسعار',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: HexColor('#65B95C')),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(widget.model.description!),
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Column(
                        children: [
                          ListTile(
                            minLeadingWidth: 1,
                            leading: Icon(
                              Icons.location_on,
                              color: Colors.grey,
                            ),
                            title: Text(
                              widget.model.addressDetails!,
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                          ),
                          ListTile(
                            minLeadingWidth: 1,
                            leading: Icon(
                              Icons.phone_in_talk_sharp,
                              color: Colors.grey,
                            ),
                            title: Text(
                              widget.model.mobileNumber!,
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MapsScreen(model: widget.model))),
                                  child: Container(
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/png/map.png'),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.circular(15)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      Divider(
                        thickness: 2,
                      ),
                      SizedBox(height: 5.h),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('الخدمات الترفيهية',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 13.h,
                            ),
                            BlocConsumer<GetEntertainmentsServicesCubit,
                                GetEntertainmentsServicesStates>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                if (state
                                    is GetEntertainmentsServicesSuccessState) if (GetEntertainmentsServicesCubit
                                            .get(context)
                                        .entertaimentServices!
                                        .length >
                                    0)
                                  return Container(
                                    height: 35.h,
                                    child: ListView.separated(
                                      itemBuilder: (context, index) =>
                                          Container(
                                        height: 35.h,
                                        width: 200.w,
                                        child: ListTile(
                                          // isThreeLine: true,
                                          horizontalTitleGap: 5,
                                          minLeadingWidth: 1,
                                          contentPadding: EdgeInsets.zero,
                                          leading: Container(
                                            height: 25.h,
                                            width: 25.w,
                                            child: mainCachedImage(
                                                url:
                                                    'http://tasha.accessline.ps/${GetEntertainmentsServicesCubit.get(context).entertaimentServices![index].iconFile}'),
                                          ),
                                          title: Text(
                                              GetEntertainmentsServicesCubit
                                                      .get(context)
                                                  .entertaimentServices![index]
                                                  .title!),
                                        ),
                                      ),
                                      separatorBuilder: (context, index) =>
                                          Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Container(
                                          height: 35.h,
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      itemCount:
                                          GetEntertainmentsServicesCubit.get(
                                                  context)
                                              .entertaimentServices!
                                              .length,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  );
                                else
                                  return Container(
                                    child: Text(
                                      'لا يوجد خدمات متوفرة حاليا',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 13.sp),
                                    ),
                                  );
                                return Container();
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Divider(
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('الحجز',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor('#4594C9'))),
                            SizedBox(height: 10.h),
                            Text('قم بتحديد فترة الحجز',
                                style: TextStyle(fontSize: 16.sp)),
                            SizedBox(
                              height: 12.h,
                            ),
                            //taps

                            BlocConsumer<GetPeriodsCubit, GetPeriodsStates>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                if (state is GetPeriodsSuccessState)
                                  return Container(
                                    width: double.infinity,
                                    child: ChipList(
                                      listOfChipNames:
                                          GetPeriodsCubit.get(context)
                                              .periods!
                                              .map((e) => e.name!)
                                              .toList(),
                                      activeBgColorList: [HexColor('#FFC010')],
                                      inactiveBgColorList: [
                                        Colors.grey.withOpacity(0.2),
                                      ],
                                      activeTextColorList: [Colors.white],
                                      inactiveTextColorList: [Colors.black],
                                      listOfChipIndicesCurrentlySeclected: [0],
                                      shouldWrap: true,
                                      runSpacing: 10,
                                      spacing: 10,
                                    ),
                                  );
                                return Container();
                              },
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            //dates
                            SfDateRangePicker(
                              headerHeight: 50.h,
                              rangeSelectionColor: defaultColor.withOpacity(0.5),
                              startRangeSelectionColor: defaultColor,
                              endRangeSelectionColor: defaultColor,
                              // backgroundColor: defaultColor,
                              controller: fController,
                              view: DateRangePickerView.month,
                              selectionMode: DateRangePickerSelectionMode.range,
                              minDate: DateTime(2022, 02, 05),
                              maxDate: DateTime(2023, 12, 30),
                              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                                final dynamic value = args.value;
                              },
                              onViewChanged: (DateRangePickerViewChangedArgs args) {
                                final PickerDateRange visibleDates = args.visibleDateRange;
                                final DateRangePickerView view = args.view;
                              },
                            ),
                            SizedBox(
                              height: 49.h,
                            ),
                            mainButton(
                                text: 'احجز الان',
                                onPressed: () {
                                  // must be logged (if there is token)
                                  showModalBottomSheet(
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15))),
                                    context: context,
                                    builder: (context) => Container(
                                      height: 448.h,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'تفاصيل الحجز',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 17.h),
                                            Text(
                                              'حجز ${widget.model.name}',
                                              style: TextStyle(fontSize: 15.sp),
                                            ),
                                            SizedBox(height: 8.h),
                                            Text(
                                              'بداية الحجز ${widget.model.name}',
                                              style: TextStyle(fontSize: 12.sp),
                                            ),
                                            SizedBox(height: 10.h),
                                            Text(
                                              'نهاية الحجز ${widget.model.name}',
                                              style: TextStyle(fontSize: 12.sp),
                                            ),
                                            SizedBox(height: 8.h),
                                            Text(
                                              'فترة الحجز ${widget.model.name}',
                                              style: TextStyle(fontSize: 12.sp),
                                            ),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                            Divider(
                                              thickness: 1.5,
                                            ),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'إجمالي المبلغ',
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Row(
                                                  children: [
                                                    Text('200',
                                                        style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: HexColor(
                                                              '#65B95C'),
                                                        )),
                                                    SizedBox(width: 2),
                                                    FaIcon(
                                                      FontAwesomeIcons
                                                          .shekelSign,
                                                      size: 15,
                                                      color:
                                                          HexColor('#65B95C'),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 30.h),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  BlocProvider<CheckBoxCubit>(
                                                    create: (context) =>
                                                        CheckBoxCubit(),
                                                    child: BlocConsumer<
                                                        CheckBoxCubit,
                                                        CheckState>(
                                                      listener:
                                                          (context, state) {
                                                        // isChecked = CheckBoxCubit
                                                        //                 .get(
                                                        //                     context)
                                                        //             .checkValue ==
                                                        //         true
                                                        //     ? true
                                                        //     : false;
                                                      },
                                                      builder:
                                                          (context, state) {
                                                        return Checkbox(
                                                          activeColor:
                                                              Colors.amber,
                                                          value:
                                                              CheckBoxCubit.get(
                                                                      context)
                                                                  .checkValue,
                                                          onChanged: (value) =>
                                                              CheckBoxCubit.get(
                                                                      context)
                                                                  .ChangeCheckValue(
                                                                      value),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Text('الموافقة على'),
                                                  TextButton(
                                                      onPressed: () {},
                                                      child: Text(
                                                          'شروط الشاليه',
                                                          style: TextStyle(
                                                              color: HexColor(
                                                                  '#6259A8')))),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 20.h),
                                            mainButton(
                                                text: 'الدفع من خلال التطبيق',
                                                onPressed: () {},
                                                backgroundColor:
                                                    HexColor('#6259A8'),
                                                textColor: Colors.white),
                                            SizedBox(height: 10.h),
                                            mainButton(
                                                text: 'الدفع اليدوي',
                                                onPressed: () {},
                                                backgroundColor: Colors.white,
                                                textColor: HexColor(
                                                  '#6259A8',
                                                ),
                                                borderColor: HexColor(
                                                  '#6259A8',
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                backgroundColor: HexColor('#6259A8'),
                                textColor: Colors.white)
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
