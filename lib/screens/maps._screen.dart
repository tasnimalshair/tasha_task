import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tasha_task/config/themes/color.dart';
import 'package:tasha_task/models/services_model.dart';

class MapsScreen extends StatefulWidget {
  final ServiceData model;

  const MapsScreen({Key? key, required this.model}) : super(key: key);

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            '${widget.model.name}',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          toolbarHeight: 108.h,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                color: defaultColor),
          )),
      //  PreferredSize(child: Container(
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
      //     color: defaultColor
      //   ),
      // ), preferredSize: Size.fromHeight(108.h)),

      // bottomSheet: showSheet(),

      
      // BottomSheet(
      //   clipBehavior: Clip.antiAlias,
      //   shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.only(
      //           topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      //   onClosing: () {},
      //   builder: (context) => Container(
      //     height: 157.h,
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.only(
      //           topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      //     ),
      //     child: Column(
      //       children: [
      //         Row(
      //           children: [
      //             ListTile(
      //               leading: Icon(Icons.location_on, color: Colors.amber),
      //               title: Text(
      //                 '${widget.model.name}',
      //                 style: TextStyle(
      //                     fontSize: 18.sp, fontWeight: FontWeight.bold),
      //               ),
      //             ),
      //             Spacer(),
      //           ],
      //         ),
      //         SizedBox(height: 8.5.h),
      //         RatingBar.builder(
      //           ignoreGestures: true,
      //           unratedColor: Colors.grey[400],
      //           itemSize: 20,
      //           initialRating: (widget.model.rate)!.toDouble(),
      //           minRating: 1,
      //           direction: Axis.horizontal,
      //           allowHalfRating: true,
      //           itemCount: 5,
      //           itemPadding: EdgeInsets.only(left: 6),
      //           itemBuilder: (context, _) => Icon(
      //             Icons.star,
      //             color: Colors.amber,
      //           ),
      //           onRatingUpdate: (rating) {
      //             print(rating);
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(double.parse(widget.model.latitude!),
              double.parse(widget.model.longitude!)),
          zoom: 14.4746,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}

class showSheet extends StatefulWidget {
  const showSheet({Key? key}) : super(key: key);

  @override
  State<showSheet> createState() => _showSheetState();
}

class _showSheetState extends State<showSheet> {
  void displayPersistentBottomSheet() {
    Scaffold.of(context).showBottomSheet<void>((BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: const Text(' My Profile '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: const Text(' My Course '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.ac_unit),
            title: const Text(' Go Premium '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.video_label),
            title: const Text(' Saved Videos '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: const Text(' Edit Profile '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text('LogOut'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
