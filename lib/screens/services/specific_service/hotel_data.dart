import 'dart:ui';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tasha_task/features/getAdvertisementsCubit.dart';
import 'package:tasha_task/features/getMenusCubit.dart';
import 'package:tasha_task/models/services_model.dart';
import 'package:tasha_task/models/specificResturantModel.dart';
import 'package:tasha_task/screens/maps._screen.dart';
import 'package:tasha_task/services/cubit.dart';
import 'package:tasha_task/services/states.dart';
import 'package:tasha_task/shared/components.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/src/bloc_consumer.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SpecificHotel extends StatefulWidget {
  final ServiceData model;
  const SpecificHotel({Key? key, required this.model}) : super(key: key);

  @override
  State<SpecificHotel> createState() => _SpecificHotelState();
}

class _SpecificHotelState extends State<SpecificHotel> {
  int _currentPage = 0;
  PageController? pageController = PageController(initialPage: 0);

  bool end = false;
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (context) => AppCubit(),
        ),
        BlocProvider<GetMenusCubit>(
          create: (context) =>
              GetMenusCubit()..getMenus(sectionID: widget.model.iD!),
        ),
      ],
      child: Scaffold(
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
          body: Column(
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
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          unratedColor: Colors.grey[400],
                          itemSize: 20,
                          initialRating: (widget.model.rate)!.toDouble(),
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
                          style: TextStyle(fontSize: 13, color: Colors.grey),
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
                          style: TextStyle(fontSize: 13, color: Colors.grey),
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
                            SizedBox(height: 50.h),
                            mainButton(
                                text: 'اتصل الان',
                                onPressed: () {},
                                backgroundColor: HexColor('#6259A8'),
                                textColor: Colors.white)
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
