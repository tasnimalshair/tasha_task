import 'dart:async';
import 'dart:ui';

import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:story_view/story_view.dart';
import 'package:tasha_task/features/getAdvertisementsCubit.dart';
import 'package:tasha_task/features/getSectionsCubit.dart';
import 'package:tasha_task/features/getServicesCubit.dart';
import 'package:tasha_task/models/section_model.dart';
import 'package:tasha_task/screens/services/chalets.dart';
import 'package:tasha_task/services/cubit.dart';
import 'package:tasha_task/services/states.dart';
import 'package:flutter_bloc/src/bloc_consumer.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:tasha_task/shared/components.dart';
import 'package:tasha_task/shared/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  // ZoomDrawerController drawerController;
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  final controller = StoryController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          // BlocProvider<AppCubit>(create: (context) => AppCubit()),
          BlocProvider<GetAdvertisementsCubit>(
            create: (context) => GetAdvertisementsCubit()..getAdvertisements(),
          ),
          BlocProvider<GetSectionsCubit>(
            create: (context) => GetSectionsCubit()..getSections(),
          ),
        ],
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                actions: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
                ],
                leading: InkWell(
                  onTap: () {},
                  child: Icon(Icons.menu),
                )),
            body: Column(children: [
              Stack(
                // overflow: Overflow.clip,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 160.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: HexColor('#6259A8'),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                  ),
                  Image.asset('assets/images/png/first.png'),
                  Image.asset('assets/images/png/second.png'),
                  Padding(
                    padding: const EdgeInsets.only(right: 25, top: 100),
                    child: Column(
                      children: [
                        Text(
                          'أهلا وسهلا',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(height: 5.h),
                        Text('في تطبيق طشة',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w300)),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(children: [
                        BlocConsumer<GetAdvertisementsCubit,
                            GetAdvertisementsStates>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            if (state is GetAdvertisementsLoadingState)
                              return Shimmer.fromColors(
                                  loop: 2,
                                  enabled: true,
                                  baseColor: Colors.grey[400]!,
                                  highlightColor: Colors.grey[200]!,
                                  child: Container(
                                    height: 160.h,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ));
                            else if (state is GetAdvertisementsFailedState)
                              return Container();
                            return Container(
                              height: 160.h,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  if (state is GetAdvertisementsFailedState)
                                    Container(),
                                  if (state is GetAdvertisementsSuccessState)
                                    PageView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          Container(
                                              clipBehavior: Clip.antiAlias,
                                              height: 160.h,
                                              child: CachedNetworkImage(
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                                placeholder: (context, url) =>
                                                    Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                imageUrl:
                                                    'http://tasha.accessline.ps/${GetAdvertisementsCubit.get(context).advertisements![index].fileName ?? ''}',
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: Container(
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image:
                                                                imageProvider)),
                                                  ),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              )),
                                      itemCount:
                                          GetAdvertisementsCubit.get(context)
                                              .advertisements!
                                              .length,
                                      controller: pageController,
                                    ),
                                  if (state is GetAdvertisementsSuccessState)
                                    Positioned(
                                        bottom: 10.h,
                                        child: SmoothPageIndicator(
                                          controller: pageController!,
                                          count: GetAdvertisementsCubit.get(
                                                  context)
                                              .advertisements!
                                              .length,
                                          axisDirection: Axis.horizontal,
                                          effect: SlideEffect(
                                              spacing: 8.0,
                                              radius: 10.0,
                                              dotWidth: 10.0,
                                              dotHeight: 10.0,
                                              // paintStyle: PaintingStyle.stroke,
                                              strokeWidth: 1.5,
                                              dotColor:
                                                  Colors.white.withOpacity(0.5),
                                              activeDotColor: Colors.white),
                                        )),
                                ],
                              ),
                            );
                          },
                        ),
                        Container(
                          // height: 80.h,
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              'اذهب الى',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        BlocConsumer<GetSectionsCubit, GetSectionsStates>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            if (state is GetSectionsFailedState)
                              return Container();
                            if (state is GetSectionsSuccessState)
                              return Container(
                                height: 330.h,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 10.h,
                                  ),
                                  itemCount: GetSectionsCubit.get(context)
                                      .sections!
                                      .length,
                                  itemBuilder: (context, index) =>
                                      buildServices(
                                    GetSectionsCubit.get(context)
                                        .sections![index],
                                  ),
                                ),
                              );
                            return Container(
                              height: 330.h,
                            );
                          },
                        )
                      ])),
                ),
              )
            ])));
  }

  Widget buildServices(SectionModel model) {
    return InkWell(
      onTap: () {
        // sectionId = sectioId;
        // GetServicesCubit.get(context).getServices(sectioId: sectioId);
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => ChaletsScreen(
        //         map: {'title': model.title, 'sectionId': model.iD},
        //       ),
        //     ));
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChaletsScreen(
                map: {'title': model.title, 'sectionId': model.iD},
              ),
            ));
      },
      child: Container(
        alignment: Alignment.centerRight,
        height: 90.h,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(
            model.title!,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: CachedNetworkImageProvider(
                    'http://tasha.accessline.ps/${model.fileName}'),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.darken),
                fit: BoxFit.cover)),
      ),
    );
  }
}
// StoryView(
// storyItems: storyItems,
// controller: controller,
// // pass controller here too
// repeat: true,
// // should the stories be slid forever
// // onStoryShow: (s) {notifyServer(s)},
// onComplete: () {},
// onVerticalSwipeComplete: (direction) {
// if (direction == Direction.down) {
// Navigator.pop(context);
// }
// }, // To disable vertical swipe gestures, ignore this parameter.
// // Preferrably for inline story view.
// ),

