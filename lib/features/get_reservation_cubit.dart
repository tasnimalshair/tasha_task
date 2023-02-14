import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:tasha_task/models/advertisement_model.dart';
import 'package:tasha_task/models/reservation_model.dart';
import 'package:tasha_task/models/section_price_model.dart';
import 'package:tasha_task/services/dio_helper.dart';
import 'package:tasha_task/services/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetReservationsCubit extends Cubit<GetReservationsStates> {
  GetReservationsCubit() : super(GetReservationsinitialState());

  static GetReservationsCubit get(context) =>
      BlocProvider.of<GetReservationsCubit>(context);

  List<ReservationModel>? reservations;

  void getReservations(
      {required String reservationDateFrom,
      required String reservationDateTo}) {
    emit(GetReservationsLoadingState());
    DioHelper.getData(
      url: GET_RESERVATIONS,
      query: {
        'PageNum': '',
        'Approved': true,
        'OrderByFirst': true,
        'ReservationDateFrom': reservationDateFrom,
        'ReservationDateTo': reservationDateTo
      },
      onSuccess: (response) {
        reservations = (response.data['data'] as List)
            .map((t) => ReservationModel.fromJson(t))
            .toList();

        emit(GetReservationsSuccessState());
      },
      onFailed: (myErrors) {
        Logger().e('ERROR ${myErrors}');
        emit(GetReservationsFailedState());
      },
    );
  }
}

abstract class GetReservationsStates {}

class GetReservationsinitialState extends GetReservationsStates {}

class GetReservationsLoadingState extends GetReservationsStates {}

class GetReservationsSuccessState extends GetReservationsStates {}

class GetReservationsFailedState extends GetReservationsStates {}
