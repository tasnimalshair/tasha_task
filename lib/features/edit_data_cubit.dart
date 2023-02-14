// import 'dart:html';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:tasha_task/data/local/my_hive.dart';
import 'package:tasha_task/models/edit_user_model.dart';
import 'package:tasha_task/services/dio_helper.dart';
import 'package:tasha_task/services/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/end_points.dart';

class EditDataCubit extends Cubit<EditDataStates> {
  EditDataCubit() : super(EditDataInitialState());
  static EditDataCubit get(context) => BlocProvider.of<EditDataCubit>(context);

  EditModel? editModel;
  void editData({
    required String FirstName,
    required String LastName,
    required String AddressDetails,
    required String MobileNumber,
    required String BirthDate,

  }) {
    emit(EditDataLoadingState());
    DioHelper.putData(
      url: EDIT_USER_DATA,
      data: FormData.fromMap({
        'FirstName': FirstName,
        'LastName': LastName,
        'AddressID' : '',
        'AddressDetails': AddressDetails,
        'MobileNumber': MobileNumber,
        'Gender' : '',
        'BirthDate': BirthDate,
        'Photo' : ''
      }),
      onSuccess: (response) {
        editModel = EditModel.fromJson(response.data);
        MyHive.updateUser(
            editModel!.data![0].firstName!,
            editModel!.data![0].lastName!,
            editModel!.data![0].addressID!,
            editModel!.data![0].addressDetails!,
            editModel!.data![0].mobileNumber!,
            editModel!.data![0].gender!,
            editModel!.data![0].birthDate!,
            editModel!.data![0].photo!);

        emit(EditDataSuccessState());
      },
      onFailed: (myErrors) {
        Logger().e('ERROR ${myErrors}');
        emit(EditDataFailedState());
      },
    );
  }
}

abstract class EditDataStates {}

class EditDataInitialState extends EditDataStates {}

class EditDataLoadingState extends EditDataStates {}

class EditDataSuccessState extends EditDataStates {}

class EditDataFailedState extends EditDataStates {}
