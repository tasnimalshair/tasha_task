import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:tasha_task/models/advertisement_model.dart';
import 'package:tasha_task/models/section_price_model.dart';
import 'package:tasha_task/services/dio_helper.dart';
import 'package:tasha_task/services/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/services_model.dart';

class GetSectionLocationsCubit extends Cubit<GetSectionLocationsStates> {
  GetSectionLocationsCubit() : super(GetSectionLocationsinitialState());

  static GetSectionLocationsCubit get(context) =>
      BlocProvider.of<GetSectionLocationsCubit>(context);

  List<ServiceData>? serviceDataList;

  void getSectionLocations(
      {required int sectionTypeID,
      required int latitude,
      required int longitude}) {
    emit(GetSectionLocationsLoadingState());
    DioHelper.getData(
      url: GET_SECTIONS_LOCATIONS,
      query: {
        'SectionTypeID': sectionTypeID,
        'Latitude': latitude,
        'Longitude': longitude
      },
      onSuccess: (response) {
        serviceDataList = (response.data['data'] as List)
            .map((t) => ServiceData.fromJson(t))
            .toList();

        // Logger().e('ADVRTISEMENTS ARE ${sectionLocations}');
        emit(GetSectionLocationsSuccessState());
      },
      onFailed: (myErrors) {
        Logger().e('ERROR ${myErrors}');
        emit(GetSectionLocationsFailedState());
      },
    );
  }

  int tabIndex=0;
  void onTap(int index){
    tabIndex=index;
    emit(OnTapTabbarState());

  }
}

abstract class GetSectionLocationsStates {}

class GetSectionLocationsinitialState extends GetSectionLocationsStates {}

class GetSectionLocationsLoadingState extends GetSectionLocationsStates {}

class GetSectionLocationsSuccessState extends GetSectionLocationsStates {}

class GetSectionLocationsFailedState extends GetSectionLocationsStates {}

class OnTapTabbarState extends GetSectionLocationsStates {}

