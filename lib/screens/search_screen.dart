import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tasha_task/features/getSearchSectionsModel.dart';
import 'package:tasha_task/screens/services/specific_service/chalet_data.dart';
import 'package:tasha_task/screens/services/specific_service/hotel_data.dart';
import 'package:tasha_task/screens/services/specific_service/resturant_data.dart';
import 'package:tasha_task/shared/components.dart';
import 'package:flutter_bloc/src/bloc_consumer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetSearchServicesCubit>(
          create: (context) => GetSearchServicesCubit(),
        ),
        // BlocProvider<GetSelectedCubit>(
        //   create: (context) => GetSelectedCubit(),
        // ),
      ],
      child: BlocConsumer<GetSearchServicesCubit, GetSearchServicesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context: context, appBarTitle: 'بحث'),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // BlocConsumer<GetSelectedCubit, GetSelectedStates>(
                  //   listener: (context, state) {},
                  //   builder: (context, state) {
                  //     return
                      buildSearchbar(
                          onChanged: (value) {
                            var cubitValue =
                            GetSearchServicesCubit.get(context).value;
                            if (state is GetChangeSelectedSuccessState) {
                              if (cubitValue == 0) {
                                GetSearchServicesCubit.get(context)
                                    .getSearchServices(
                                        sectioId: 0, name: value);
                              } else if (cubitValue == 1) {
                                GetSearchServicesCubit.get(context)
                                    .getSearchServices(
                                        sectioId: 1, name: value);
                              } else if (cubitValue == 2) {
                                GetSearchServicesCubit.get(context)
                                    .getSearchServices(
                                        sectioId: 2, name: value);
                              } else if (cubitValue == 3) {
                                GetSearchServicesCubit.get(context)
                                    .getSearchServices(
                                        sectioId: 3, name: value);
                              } else
                                GetSearchServicesCubit.get(context)
                                    .getSearchServices(name: value);
                            } else {
                              GetSearchServicesCubit.get(context)
                                  .getSearchServices(name: value);
                            }
                          },
                          hintText: 'ابحث هنا',
                          onTap: () {}),
                      SizedBox(height: 10.h),
                      Container(
                        alignment: Alignment.center,
                        height: 70.h,
                        child: DefaultTabController(
                            length: 3,
                            child: Scaffold(
                                appBar: AppBar(
                                  backgroundColor: Colors.white,
                                  elevation: 0,
                                  bottom: TabBar(
                                    onTap: (value) => GetSearchServicesCubit.get(context).changeSelected(true,value),
                                      unselectedLabelColor:
                                          Colors.redAccent,
                                      indicatorSize:
                                          TabBarIndicatorSize.label,
                                      indicator: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.redAccent),
                                      tabs: [
                                        Tab(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50),
                                                border: Border.all(
                                                    color: Colors.redAccent,
                                                    width: 1)),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text("الشاليهات"),
                                            ),
                                          ),
                                        ),
                                        Tab(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50),
                                                border: Border.all(
                                                    color: Colors.redAccent,
                                                    width: 1)),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text("الفنادق"),
                                            ),
                                          ),
                                        ),
                                        Tab(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50),
                                                border: Border.all(
                                                    color: Colors.redAccent,
                                                    width: 1)),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text("المطاعم"),
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                                // body: state is GetSearchServicesSuccessState
                                //     ? TabBarView(children: [
                                //         Center(child: Icon(Icons.apps)),
                                //         Icon(Icons.movie),
                                //         Icon(Icons.games),
                                //       ])
                                //     :
                                // Expanded(
                                //   child: Column(
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     crossAxisAlignment: CrossAxisAlignment.center,
                                //     children: [
                                //       Image.asset(
                                //         'assets/images/png/search.png',
                                //         fit: BoxFit.cover,
                                //       ),
                                //     ],
                                //   ),
                                // ),
                            )),




                      ),
                  //   },
                  // ),
                  Divider(thickness: 1.5),

                  if (state is GetSearchServicesLoadingState)
                    Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),

                  if (state is GetSearchServicesSuccessState)
                    if (GetSearchServicesCubit.get(context)
                            .servicesData!
                            .length >
                        0)
                      Expanded(
                        child: Container(
                          // height: 700.h,
                          child: ListView.separated(
                              itemBuilder: (context, index) =>
                                  buildHotelContainer(
                                    onTap: (model) {
                                      if (model.sectionType == 1) {
                                        navigate(
                                            context: context,
                                            widget: SpecificChalet(
                                              model: model,
                                            ));
                                      } else if (model.sectionType == 2) {
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
                                    model: GetSearchServicesCubit.get(context)
                                        .servicesData![index],
                                  ),
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 12.h,
                                  ),
                              itemCount: GetSearchServicesCubit.get(context)
                                  .servicesData!
                                  .length),
                        ),
                      )
                    else
                      Expanded(child: Center(child: Text('لا يوجد نتائج !')))
                  // else if (state is GetSSearchervicesinitialState)
                  //   Expanded(
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Image.asset(
                  //           'assets/images/png/search.png',
                  //           fit: BoxFit.cover,
                  //         ),
                  //       ],
                  //     ),
                  //   ),

                  // Expanded(
                  //     child: SingleChildScrollView(
                  //   child: Container(
                  //     child: state is GetSearchServicesSuccessState
                  //         ? GetSearchServicesCubit.get(context)
                  //                     .servicesData!
                  //                     .length >
                  //                 0
                  //             ? Expanded(
                  //                 child: ListView.separated(
                  //                     itemBuilder: (context, index) =>
                  //                         buildHotelContainer(
                  //                           onTap: (model) {
                  //                             if (model.sectionType == 1) {
                  //                               navigate(
                  //                                   context: context,
                  //                                   widget: SpecificChalet(
                  //                                     model: model,
                  //                                   ));
                  //                             } else if (model.sectionType ==
                  //                                 2) {
                  //                               navigate(
                  //                                   context: context,
                  //                                   widget: SpecificHotel(
                  //                                     model: model,
                  //                                   ));
                  //                             } else {
                  //                               navigate(
                  //                                   context: context,
                  //                                   widget: SpecificResturant(
                  //                                     model: model,
                  //                                   ));
                  //                             }
                  //                           },
                  //                           model: GetSearchServicesCubit.get(
                  //                                   context)
                  //                               .servicesData![index],
                  //                         ),
                  //                     separatorBuilder: (context, index) =>
                  //                         SizedBox(
                  //                           height: 12.h,
                  //                         ),
                  //                     itemCount:
                  //                         GetSearchServicesCubit.get(context)
                  //                             .servicesData!
                  //                             .length),
                  //               )
                  //             : Center(
                  //                 child: Text('no'),
                  //               )
                  //         : Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
                  //               Padding(
                  //                 padding:
                  //                     const EdgeInsets.symmetric(vertical: 130),
                  //                 child: Image.asset(
                  //                   'assets/images/png/search.png',
                  //                   fit: BoxFit.cover,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //   ),
                  // ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Scaffold(
// appBar: buildAppBar(context: context, appBarTitle: 'بحث'),
// body: Padding(
// padding: const EdgeInsets.all(20.0),
// child: Column(
// children: [
// BlocConsumer<GetSelectedCubit, GetSelectedStates>(
// listener: (context, state) {},
// builder: (context, state) {
// return Column(
// children: [
// buildSearchbar(
// onChanged: (value) {
// var cubitValue =
// GetSelectedCubit.get(context).value;
// if (state is GetchangeSelectedState) {
// if (cubitValue == 0) {
// GetSearchServicesCubit.get(context)
//     .getSearchServices(
// sectioId: 0, name: value);
// } else if (cubitValue == 1) {
// GetSearchServicesCubit.get(context)
//     .getSearchServices(
// sectioId: 1, name: value);
// } else if (cubitValue == 2) {
// GetSearchServicesCubit.get(context)
//     .getSearchServices(
// sectioId: 2, name: value);
// } else if (cubitValue == 3) {
// GetSearchServicesCubit.get(context)
//     .getSearchServices(
// sectioId: 3, name: value);
// } else
// GetSearchServicesCubit.get(context)
//     .getSearchServices(name: value);
// } else {
// GetSearchServicesCubit.get(context)
//     .getSearchServices(name: value);
// }
// },
// hintText: 'ابحث هنا',
// onTap: () {}),
// SizedBox(height: 10.h),
// Container(
// alignment: Alignment.center,
// height: 200.h,
// child: DefaultTabController(
// length: 3,
// child: Scaffold(
// appBar: AppBar(
// backgroundColor: Colors.white,
// elevation: 0,
// bottom: TabBar(
// unselectedLabelColor:
// Colors.redAccent,
// indicatorSize:
// TabBarIndicatorSize.label,
// indicator: BoxDecoration(
// borderRadius:
// BorderRadius.circular(50),
// color: Colors.redAccent),
// tabs: [
// Tab(
// child: Container(
// decoration: BoxDecoration(
// borderRadius:
// BorderRadius.circular(
// 50),
// border: Border.all(
// color: Colors.redAccent,
// width: 1)),
// child: Align(
// alignment: Alignment.center,
// child: Text("APPS"),
// ),
// ),
// ),
// Tab(
// child: Container(
// decoration: BoxDecoration(
// borderRadius:
// BorderRadius.circular(
// 50),
// border: Border.all(
// color: Colors.redAccent,
// width: 1)),
// child: Align(
// alignment: Alignment.center,
// child: Text("MOVIES"),
// ),
// ),
// ),
// Tab(
// child: Container(
// decoration: BoxDecoration(
// borderRadius:
// BorderRadius.circular(
// 50),
// border: Border.all(
// color: Colors.redAccent,
// width: 1)),
// child: Align(
// alignment: Alignment.center,
// child: Text("GAMES"),
// ),
// ),
// ),
// ]),
// ),
// body: state is GetSearchServicesSuccessState
// ? TabBarView(children: [
// Center(child: Icon(Icons.apps)),
// Icon(Icons.movie),
// Icon(Icons.games),
// ])
//     :
// Expanded(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Image.asset(
// 'assets/images/png/search.png',
// fit: BoxFit.cover,
// ),
// ],
// ),
// ),)),
//
//
//
//
// ),
// // Wrap(
// //   children: List<Widget>.generate(
// //     4,
// //     (int index) {
// //       var list = [
// //         'الكل',
// //         'الشاليهات',
// //         'الفنادق',
// //         'المطاعم'
// //       ];
// //       return ChoiceChip(
// //         label: Text(list[index],
// //             style: TextStyle(
// //               fontSize: 13.sp,
// //             )),
// //         selected: GetSelectedCubit.get(context)
// //                 .value ==
// //             index,
// //         onSelected: (bool selected) {
// //           GetSelectedCubit.get(context)
// //               .changeSelected(selected, index);
// //         },
// //       );
// //     },
// //   ).toList(),
// // ),
// ],
// );
// },
// ),
// Divider(thickness: 1.5),
//
// if (state is GetSearchServicesLoadingState)
// Expanded(
// child: Center(
// child: CircularProgressIndicator(),
// ),
// ),
//
// if (state is GetSearchServicesSuccessState)
// if (GetSearchServicesCubit.get(context)
// .servicesData!
// .length >
// 0)
// Expanded(
// child: Container(
// // height: 700.h,
// child: ListView.separated(
// itemBuilder: (context, index) =>
// buildHotelContainer(
// onTap: (model) {
// if (model.sectionType == 1) {
// navigate(
// context: context,
// widget: SpecificChalet(
// model: model,
// ));
// } else if (model.sectionType == 2) {
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
// model: GetSearchServicesCubit.get(context)
// .servicesData![index],
// ),
// separatorBuilder: (context, index) => SizedBox(
// height: 12.h,
// ),
// itemCount: GetSearchServicesCubit.get(context)
// .servicesData!
// .length),
// ),
// )
// else
// Expanded(child: Center(child: Text('لا يوجد نتائج !')))
// // else if (state is GetSSearchervicesinitialState)
// //   Expanded(
// //     child: Column(
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       crossAxisAlignment: CrossAxisAlignment.center,
// //       children: [
// //         Image.asset(
// //           'assets/images/png/search.png',
// //           fit: BoxFit.cover,
// //         ),
// //       ],
// //     ),
// //   ),
//
// // Expanded(
// //     child: SingleChildScrollView(
// //   child: Container(
// //     child: state is GetSearchServicesSuccessState
// //         ? GetSearchServicesCubit.get(context)
// //                     .servicesData!
// //                     .length >
// //                 0
// //             ? Expanded(
// //                 child: ListView.separated(
// //                     itemBuilder: (context, index) =>
// //                         buildHotelContainer(
// //                           onTap: (model) {
// //                             if (model.sectionType == 1) {
// //                               navigate(
// //                                   context: context,
// //                                   widget: SpecificChalet(
// //                                     model: model,
// //                                   ));
// //                             } else if (model.sectionType ==
// //                                 2) {
// //                               navigate(
// //                                   context: context,
// //                                   widget: SpecificHotel(
// //                                     model: model,
// //                                   ));
// //                             } else {
// //                               navigate(
// //                                   context: context,
// //                                   widget: SpecificResturant(
// //                                     model: model,
// //                                   ));
// //                             }
// //                           },
// //                           model: GetSearchServicesCubit.get(
// //                                   context)
// //                               .servicesData![index],
// //                         ),
// //                     separatorBuilder: (context, index) =>
// //                         SizedBox(
// //                           height: 12.h,
// //                         ),
// //                     itemCount:
// //                         GetSearchServicesCubit.get(context)
// //                             .servicesData!
// //                             .length),
// //               )
// //             : Center(
// //                 child: Text('no'),
// //               )
// //         : Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               Padding(
// //                 padding:
// //                     const EdgeInsets.symmetric(vertical: 130),
// //                 child: Image.asset(
// //                   'assets/images/png/search.png',
// //                   fit: BoxFit.cover,
// //                 ),
// //               ),
// //             ],
// //           ),
// //   ),
// // ))
// ],
// ),
// ),
// );


