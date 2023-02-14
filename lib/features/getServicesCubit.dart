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

class GetServicesCubit extends Cubit<GetServicesStates> {
  GetServicesCubit() : super(GetServicesinitialState());

  static GetServicesCubit get(context) =>
      BlocProvider.of<GetServicesCubit>(context);
      

  List<ServiceData>? servicesData;
  // GET LIST OF RESTURANTS OR HOTELS .....ETC
  void getServices({required int sectioId,String? name,
  int? priceFrom,
  int? priceTo,
  int? periodTypeID,
  bool? orderByNearest,
  int? governorateID}) {
    emit(GetServicesLoadingState());
    DioHelper.getData(
      url: GET_SERVICES,
      query: {
        'SectionTypeID': sectioId,
        'Latitude': '',
        'Longitude': '',
        'Name': name,
        'PriceFrom' : priceFrom,
        'PriceTo' : priceTo,
        'PeriodTypeID' : periodTypeID,
        'OrderByNearest' : orderByNearest,
        'GovernorateID' : governorateID

      },
      onSuccess: (response) {
        // Logger().e('RV iS ${response.data}');
        servicesData = (response.data['data'] as List)
            .map((x) => ServiceData.fromJson(x))
            .toList();

        emit(GetServicesSuccessState());
      },
      onFailed: (myErrors) {
        Logger().e('ERROR ${myErrors}');
        emit(GetServicesFailedState());
      },
    );
  }

  // var _currentRangeValues =  RangeValues(40, 80);

}

abstract class GetServicesStates {}

class GetServicesinitialState extends GetServicesStates {}

class GetServicesLoadingState extends GetServicesStates {}

class GetServicesSuccessState extends GetServicesStates {}

class GetServicesFailedState extends GetServicesStates {}
