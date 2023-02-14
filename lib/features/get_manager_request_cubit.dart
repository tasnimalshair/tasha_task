import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:tasha_task/models/advertisement_model.dart';
import 'package:tasha_task/models/menu_model.dart';
import 'package:tasha_task/models/period_mpdel.dart';
import 'package:tasha_task/models/section_model.dart';
import 'package:tasha_task/models/services_model.dart';
import 'package:tasha_task/screens/services/chalets.dart';
import 'package:tasha_task/services/dio_helper.dart';
import 'package:tasha_task/services/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/manager_request_model.dart';

class GetManagerRequestCubit extends Cubit<GetManagerRequestStates> {
  GetManagerRequestCubit() : super(GetManagerRequestinitialState());

  static GetManagerRequestCubit get(context) =>
      BlocProvider.of<GetManagerRequestCubit>(context);

  ManagerRequestModel? managerRequestModel;
  void getManagerRequest(
      {required String addressDetails,
      required int addressID,
      required String name,
      required int sectionType,
      required String notes}) {
    emit(GetManagerRequestLoadingState());
    DioHelper.postData(
      url: GET_SECTIOS_REQUEST,
      data: {
        'addressDetails': addressDetails,
        'addressID': addressID,
        'name': name,
        'sectionType': sectionType,
        'notes': notes
      },
      onSuccess: (response) {
        managerRequestModel = ManagerRequestModel.fromJson(response.data);
        emit(GetManagerReqestSuccessState(managerRequestModel!));
      },
      onFailed: (myErrors) {
        Logger().e('ERROR ${myErrors}');
        emit(GetManagerReqestFailedState());
      },
    );
  }
}

abstract class GetManagerRequestStates {}

class GetManagerRequestinitialState extends GetManagerRequestStates {}

class GetManagerRequestLoadingState extends GetManagerRequestStates {}

class GetManagerReqestSuccessState extends GetManagerRequestStates {
  final ManagerRequestModel model;
  GetManagerReqestSuccessState(this.model);
}

class GetManagerReqestFailedState extends GetManagerRequestStates {}
