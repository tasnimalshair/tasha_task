import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:tasha_task/features/get_reservation_cubit.dart';
import 'package:tasha_task/shared/components.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_bloc/src/bloc_consumer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservationsScreen extends StatelessWidget {
  const ReservationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetReservationsCubit>(
      create: (context) => GetReservationsCubit()
        ..getReservations(
            reservationDateFrom: '2022-01-01', reservationDateTo: '2030-01-01'),
      child: BlocConsumer<GetReservationsCubit, GetReservationsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: buildAppBar(context: context, appBarTitle: 'حجوزاتي'),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: ConditionalBuilder(
                  condition: state is GetReservationsSuccessState,
                  fallback: (context) => Center(child: CircularProgressIndicator()),
                  builder: (context) =>  ListView.separated(
                      itemBuilder: (context, index) => Container(
                        height: 135.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey.shade200)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
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
                                        borderRadius:
                                        BorderRadius.circular(15),
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                'https://pix10.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?ca=6&ce=1&s=1024x768'),
                                            fit: BoxFit.cover)),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  if (state is GetReservationsSuccessState)
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          GetReservationsCubit.get(context)
                                              .reservations![index]
                                              .sectionName!,
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          'بداية الحجز ${GetReservationsCubit.get(context).reservations![index].reservationDateFrom} ',
                                          style: TextStyle(fontSize: 11.sp),
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          'نهاية الحجز ${GetReservationsCubit.get(context).reservations![index].reservationDateTo}',
                                          style: TextStyle(fontSize: 11.sp),
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          'تكلفة الحجز ${GetReservationsCubit.get(context).reservations![index].totalAmount} ',
                                          style: TextStyle(fontSize: 11.sp),
                                        ),
                                      ],
                                    )
                                ],
                              ),
                              SizedBox(height: 8.h),
                              if (state is GetReservationsSuccessState)
                                Container(
                                  alignment: Alignment.center,
                                  width: 125.w,
                                  height: 28.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.shade300),
                                  child: Text(
                                    'الطلب ${GetReservationsCubit.get(context).reservations![index].statusName}',
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 15.h),
                      itemCount: GetReservationsCubit.get(context).reservations!.length),
                ),
              ));
        },
      ),
    );
  }
}
//
// Container(
// height: 135.h,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(20),
// border: Border.all(color: Colors.grey.shade200)),
// child: Padding(
// padding:
// const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Row(
// children: [
// Container(
// clipBehavior: Clip.antiAlias,
// height: 80.h,
// width: 80.w,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(15),
// image: DecorationImage(
// image: CachedNetworkImageProvider(
// 'https://pix10.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?ca=6&ce=1&s=1024x768'),
// fit: BoxFit.cover)),
// ),
// SizedBox(
// width: 10.w,
// ),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// ,
// style: TextStyle(
// fontSize: 14.sp,
// fontWeight: FontWeight.bold),
// ),
// SizedBox(height: 5.h),
// Text(
// 'بداية الحجز ',
// style: TextStyle(fontSize: 11.sp),
// ),
// SizedBox(height: 5.h),
// Text(
// 'نهاية الحجز ',
// style: TextStyle(fontSize: 11.sp),
// ),
// SizedBox(height: 5.h),
// Text(
// 'تكلفة الحجز ',
// style: TextStyle(fontSize: 11.sp),
// ),
// ],
// )
// ],
// ),
// SizedBox(height: 8.h),
// Container(
// alignment: Alignment.center,
// width: 125.w,
// height: 28.h,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(5),
// color: Colors.grey.shade300),
// child: Text(
// 'الطلب',
// style: TextStyle(
// fontSize: 11.sp, fontWeight: FontWeight.bold),
// ),
// )
// ],
// ),
// ),
// )
