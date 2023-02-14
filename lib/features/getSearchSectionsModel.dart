// import 'package:bloc/bloc.dart';
// import 'package:logger/logger.dart';
// import 'package:tasha_task/models/advertisement_model.dart';
// import 'package:tasha_task/models/menu_model.dart';
// import 'package:tasha_task/models/period_mpdel.dart';
// import 'package:tasha_task/models/section_model.dart';
// import 'package:tasha_task/models/services_model.dart';
// import 'package:tasha_task/screens/services/chalets.dart';
// import 'package:tasha_task/services/dio_helper.dart';
// import 'package:tasha_task/services/end_points.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class GetSearchServicesCubit extends Cubit<GetSearchServicesStates> {
//   GetSearchServicesCubit() : super(GetSearchServicesinitialState());

//   static GetSearchServicesCubit get(context) => BlocProvider.of<GetSearchServicesCubit>(context);

//   List<ServiceData>? services;
//   void getSearchServices({required int sectionTypeID} ) {
//     emit(GetSearchServicesLoadingState());
//     DioHelper.getData(
//       url: GET_SEARCH_SECTIONS,
//       query: {'SectionTypeID' : sectionTypeID},
//       onSuccess: (response) {
//         services = (response.data['data'] as List)
//             .map((t) => ServiceData.fromJson(t))
//             .toList();

//         Logger().e('MENUS ARE ${services}');
//         emit(GetSearchServicesSuccessState());
//       },
//       onFailed: (myErrors) {
//         Logger().e('ERROR ${myErrors}');
//         emit(GetSearchServicesFailedState());
//       },
//     );
//   }
// }

// abstract class GetSearchServicesStates {}

// class GetSearchServicesinitialState extends GetSearchServicesStates {}

// class GetSearchServicesLoadingState extends GetSearchServicesStates {}

// class GetSearchServicesSuccessState extends GetSearchServicesStates {}

// class GetSearchServicesFailedState extends GetSearchServicesStates {}

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:tasha_task/models/advertisement_model.dart';
import 'package:tasha_task/models/section_model.dart';
import 'package:tasha_task/models/services_model.dart';
import 'package:tasha_task/screens/services/chalets.dart';
import 'package:tasha_task/services/dio_helper.dart';
import 'package:tasha_task/services/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';

class GetSearchServicesCubit extends Cubit<GetSearchServicesStates> {
  GetSearchServicesCubit() : super(GetSSearchervicesinitialState());

  static GetSearchServicesCubit get(context) =>
      BlocProvider.of<GetSearchServicesCubit>(context);

  List<ServiceData>? servicesData;
  // GET LIST OF RESTURANTS OR HOTELS .....ETC
  void getSearchServices({int sectioId = 0, String name = ''}) {
    emit(GetSearchServicesLoadingState());
    DioHelper.getData(
      url: GET_SEARCH_SECTIONS,
      query: {'SectionTypeID': sectioId, 'Name': name},
      onSuccess: (response) {
        // Logger().e('RV iS ${response.data}');
        servicesData = (response.data['data'] as List)
            .map((x) => ServiceData.fromJson(x))
            .toList();

        emit(GetSearchServicesSuccessState());
      },
      onFailed: (myErrors) {
        Logger().e('ERROR ${myErrors}');
        emit(GetSearchServicesFailedState());
      },
    );




  }

  var value = 0;
  void changeSelected(bool selected, index) {
    emit(GetChangeSelectedLoadingState());
    value = selected ? index : null;
    emit(GetChangeSelectedSuccessState());
  }
}

abstract class GetSearchServicesStates {}

class GetSSearchervicesinitialState extends GetSearchServicesStates {}

class GetSearchServicesLoadingState extends GetSearchServicesStates {}

class GetSearchServicesSuccessState extends GetSearchServicesStates {}

class GetSearchServicesFailedState extends GetSearchServicesStates {}

class GetChangeSelectedLoadingState extends GetSearchServicesStates {}

class GetChangeSelectedSuccessState extends GetSearchServicesStates {}


//
// class GetSelectedCubit extends Cubit<GetSelectedStates> {
//   GetSelectedCubit() : super(GetSelectedinitialState());
//
//   static GetSelectedCubit get(context) =>
//       BlocProvider.of<GetSelectedCubit>(context);
//
//   var value = 0;
//   void changeSelected(bool selected, index) {
//     emit(GetchangeSelectedLoadingState());
//     value = selected ? index : null;
//     emit(GetchangeSelectedState());
//   }
// }
// abstract class GetSelectedStates {}
//
// class GetSelectedinitialState extends GetSelectedStates {}
//
// class GetchangeSelectedLoadingState extends GetSelectedStates {}
//
// class GetchangeSelectedState extends GetSelectedStates {}
