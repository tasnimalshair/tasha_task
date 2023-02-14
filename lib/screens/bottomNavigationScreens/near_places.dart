import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:tasha_task/config/themes/color.dart';
import 'package:tasha_task/features/getSectionsCubit.dart';
import 'package:tasha_task/models/section_model.dart';
import 'package:tasha_task/shared/components.dart';
import 'package:flutter_bloc/src/bloc_consumer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/get_sections_locations_cubit.dart';
import '../services/specific_service/chalet_data.dart';
import '../services/specific_service/hotel_data.dart';
import '../services/specific_service/resturant_data.dart';
import 'package:oktoast/oktoast.dart';


class NearPlacesScreen extends StatefulWidget {
  const NearPlacesScreen({Key? key}) : super(key: key);

  @override
  State<NearPlacesScreen> createState() => _NearPlacesScreenState();
}

class _NearPlacesScreenState extends State<NearPlacesScreen> {
   late LatLng currentPostion;


  void _getUserLocation() async {
    Position  position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    Logger().e('LATITUDE ${position.latitude}');

    setState(() {
      currentPostion = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getUserLocation();
    super.initState();

  }

  bool markClicked=false;



  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetSectionsCubit>(
            create: (context) => GetSectionsCubit()..getSections()),
        BlocProvider<GetSectionLocationsCubit>(
            create: (context) => GetSectionLocationsCubit(),)
      ],
      child: BlocConsumer<GetSectionsCubit, GetSectionsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // if (state is GetSectionsSuccessState)
          // var sections;
          // GetSectionsCubit.get(context).sections!.forEach((element) {sections.add(element.title);});

          return DefaultTabController(
            length: GetSectionsCubit.get(context).sections!.length,
            child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                toolbarHeight: 100.h,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                backgroundColor: defaultColor,
                title: Text('الأماكن القريبة'),
                centerTitle: true,
                bottom: TabBar(
                  onTap: (value) => GetSectionLocationsCubit.get(context).onTap(value),
                    unselectedLabelColor: Colors.black,
                    labelColor: Colors.amber,
                    indicatorColor: Colors.transparent,
                    // labelStyle: TextStyle(),
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    tabs: GetSectionsCubit.get(context)
                        .sections!
                        .map(
                          (e) => Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  e.title!,
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList()
                    // : []

                    ),
              ),
              body: BlocConsumer<GetSectionLocationsCubit,
                  GetSectionLocationsStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  GetSectionLocationsCubit.get(context).getSectionLocations(
                      sectionTypeID:
                          GetSectionLocationsCubit.get(context).tabIndex + 1,
                      latitude: int.parse(currentPostion.latitude.toString()),
                      longitude:
                          int.parse(currentPostion.longitude.toString()));
                  if (state is GetSectionLocationsSuccessState)
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        TabBarView(children: [
                          // Center(child: Text('aaaa')),Text('bbbb'),Text('cccc')

                          GoogleMap(
                            markers: GetSectionLocationsCubit.get(context)
                                .serviceDataList!
                                .map<Marker>((e) => Marker(
                              onTap: () {

                                var widget=
                                buildHotelContainer(
                                  model: e,
                                  withPrice: e.sectionType == 3
                                      ? false
                                      : true,
                                  onTap: (model) {
                                    if (e.sectionType == 1) {
                                      navigate(
                                          context: context,
                                          widget: SpecificChalet(
                                            model: model,
                                          ));
                                    } else if (e.sectionType == 2) {
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
                                );

                                showToastWidget(
                                    widget,
                                context: context,
                                position: ToastPosition.bottom,
                                duration: Duration(days: 1));


                                // buildHotelContainer(
                                //   withPrice: widget.map['sectionId'] == 3
                                //       ? false
                                //       : true,
                                //   onTap: (model) {
                                //     if (widget.map['sectionId'] == 1) {
                                //       navigate(
                                //           context: context,
                                //           widget: SpecificChalet(
                                //             model: model,
                                //           ));
                                //     } else if (widget.map['sectionId'] == 2) {
                                //       navigate(
                                //           context: context,
                                //           widget: SpecificHotel(
                                //             model: model,
                                //           ));
                                //     } else {
                                //       navigate(
                                //           context: context,
                                //           widget: SpecificResturant(
                                //             model: model,
                                //           ));
                                //     }
                                //   },
                                //   model: GetServicesCubit.get(context)
                                //       .servicesData![index],
                                // );

                              },
                                    markerId: MarkerId(e.name!),
                                    position: LatLng(double.parse(e.latitude!),
                                        double.parse(e.longitude!))))
                                .toList()
                                .toSet(),
                            mapType: MapType.normal,
                            initialCameraPosition: CameraPosition(
                              target: currentPostion,
                              zoom: 14.4746,
                            ),
                            onMapCreated: (GoogleMapController controller) {
                              if (_controller.isCompleted == false)
                                _controller.complete(controller);
                            },
                          ),
                          GoogleMap(
                            markers: GetSectionLocationsCubit.get(context)
                                .serviceDataList!
                                .map<Marker>((e) => Marker(
                                    markerId: MarkerId(e.name!),
                                    position: LatLng(double.parse(e.latitude!),
                                        double.parse(e.longitude!))))
                                .toList()
                                .toSet(),
                            mapType: MapType.normal,
                            initialCameraPosition: CameraPosition(
                              target: currentPostion,
                              zoom: 14.4746,
                            ),
                            onMapCreated: (GoogleMapController controller) {
                              if (_controller.isCompleted == false)
                                _controller.complete(controller);
                            },
                          ),
                          GoogleMap(
                            markers: GetSectionLocationsCubit.get(context)
                                .serviceDataList!
                                .map<Marker>((e) => Marker(
                              onTap: () => markClicked=true,
                                    markerId: MarkerId(e.name!),
                                    position: LatLng(double.parse(e.latitude!),
                                        double.parse(e.longitude!))))
                                .toList()
                                .toSet(),
                            mapType: MapType.normal,
                            initialCameraPosition: CameraPosition(
                              target: currentPostion,
                              zoom: 14.4746,
                            ),
                            onMapCreated: (GoogleMapController controller) {
                              if (_controller.isCompleted == false)
                                _controller.complete(controller);
                            },
                          ),
                          // GoogleMap(
                          // markers: GetSectionLocationsCubit.get(context)
                          //     .serviceDataList!
                          //     .map<Marker>((e) =>
                          //     Marker(
                          //         markerId: MarkerId(e.name!),
                          //         position: LatLng(double.parse(e.latitude!), double.parse(e.longitude!)))
                          // ).toList().toSet(),
                          //   mapType: MapType.normal,
                          //   initialCameraPosition: CameraPosition(
                          //     target:currentPostion,
                          //     zoom: 14.4746,
                          //   ),
                          //   onMapCreated: (GoogleMapController controller) {
                          // if(_controller.isCompleted == false)  _controller.complete(controller);
                          //   },
                          // ),
                        ]),


                        // if(markClicked)
                        // buildHotelContainer(
                        //   model: GetSectionLocationsCubit.get(context).serviceDataList![0],
                        //   withPrice: GetSectionLocationsCubit.get(context).serviceDataList![0].sectionType == 3
                        //       ? false
                        //       : true,
                        //   onTap: (model) {
                        //     if (GetSectionLocationsCubit.get(context).serviceDataList![0].sectionType == 1) {
                        //       navigate(
                        //           context: context,
                        //           widget: SpecificChalet(
                        //             model: model,
                        //           ));
                        //     } else if (GetSectionLocationsCubit.get(context).serviceDataList![0].sectionType == 2) {
                        //       navigate(
                        //           context: context,
                        //           widget: SpecificHotel(
                        //             model: model,
                        //           ));
                        //     } else {
                        //       navigate(
                        //           context: context,
                        //           widget: SpecificResturant(
                        //             model: model,
                        //           ));
                        //     }
                        //   },
                        //   // model: GetServicesCubit.get(context)
                        //   //     .servicesData![index],
                        // ),
                      ],
                    );
                  return Container();
                },
              ),
            ),
          );
          return Container();
        },
      ),
    );
  }
}
