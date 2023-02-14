import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:tasha_task/models/advertisement_model.dart';
import 'package:tasha_task/services/dio_helper.dart';
import 'package:tasha_task/services/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetAdvertisementsCubit extends Cubit<GetAdvertisementsStates> {
  GetAdvertisementsCubit() : super(GetAdvertisementsinitialState());

  static GetAdvertisementsCubit get(context) =>
      BlocProvider.of<GetAdvertisementsCubit>(context);

  List<AdvertisementModel>? advertisements;

  void getAdvertisements() {
    emit(GetAdvertisementsLoadingState());
    DioHelper.getData(
      url: GET_ADVRTISEMENTS,
      onSuccess: (response) {
        // Logger().e('RV iS ${response.data['rv']}');
        advertisements = (response.data['data'] as List)
            .map((t) => AdvertisementModel.fromJson(t))
            .toList();

        Logger().e('ADVRTISEMENTS ARE ${advertisements}');
        emit(GetAdvertisementsSuccessState());
      },
      onFailed: (myErrors) {
        Logger().e('ERROR ${myErrors}');
        emit(GetAdvertisementsFailedState());
      },
    );
  }
}

abstract class GetAdvertisementsStates {}

class GetAdvertisementsinitialState extends GetAdvertisementsStates {}

class GetAdvertisementsLoadingState extends GetAdvertisementsStates {}

class GetAdvertisementsSuccessState extends GetAdvertisementsStates {}

class GetAdvertisementsFailedState extends GetAdvertisementsStates {}
