import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:tasha_task/models/advertisement_model.dart';
import 'package:tasha_task/models/entertainment_service_model.dart';
import 'package:tasha_task/services/dio_helper.dart';
import 'package:tasha_task/services/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetEntertainmentsServicesCubit extends Cubit<GetEntertainmentsServicesStates> {
  GetEntertainmentsServicesCubit() : super(GetEntertainmentsServicesinitialState());

  static GetEntertainmentsServicesCubit get(context) =>
      BlocProvider.of<GetEntertainmentsServicesCubit>(context);

  List<EntertainmentServiceModel>? entertaimentServices;

  void getEntertainmentsServices({
    required int sectionID,
    required int SectionTypeID

  }) {
    emit(GetEntertainmentsServicesLoadingState());
    DioHelper.getData(
      url: GET_ENTERTAINMENT_SERVICES,
      query: {
        'SectionID' : sectionID,
        'SectionTypeID' :SectionTypeID
      },
      onSuccess: (response) {
        entertaimentServices = (response.data['data'] as List)
            .map((t) => EntertainmentServiceModel.fromJson(t))
            .toList();

        Logger().e('ENTERTAINMENT SERVICES ARE ${entertaimentServices}');
        emit(GetEntertainmentsServicesSuccessState());
      },
      onFailed: (myErrors) {
        Logger().e('ERROR ${myErrors}');
        emit(GetEntertainmentsServicesFailedState());
      },
    );
  }
}

abstract class GetEntertainmentsServicesStates {}

class GetEntertainmentsServicesinitialState extends GetEntertainmentsServicesStates {}

class GetEntertainmentsServicesLoadingState extends GetEntertainmentsServicesStates {}

class GetEntertainmentsServicesSuccessState extends GetEntertainmentsServicesStates {}

class GetEntertainmentsServicesFailedState extends GetEntertainmentsServicesStates {}
