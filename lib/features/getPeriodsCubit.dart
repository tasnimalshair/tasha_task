import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:tasha_task/models/advertisement_model.dart';
import 'package:tasha_task/models/period_mpdel.dart';
import 'package:tasha_task/models/section_model.dart';
import 'package:tasha_task/models/services_model.dart';
import 'package:tasha_task/screens/services/chalets.dart';
import 'package:tasha_task/services/dio_helper.dart';
import 'package:tasha_task/services/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetPeriodsCubit extends Cubit<GetPeriodsStates> {
  GetPeriodsCubit() : super(GetPeriodsinitialState());

  static GetPeriodsCubit get(context) =>
      BlocProvider.of<GetPeriodsCubit>(context);


  var dropDownValue;

  void onChangeItem(value) {
    dropDownValue = value;
    emit(GetPeriodsChangeMenuItemState());
  }
  List<PeriodModel>? periods;
  void getPeriods() {
    emit(GetPeriodsLoadingState());
    DioHelper.getData(
      url: GET_PERIODS,
      onSuccess: (response) {
        Logger().e('RV iS ${response.data['rv']}');
        periods = (response.data['data'] as List)
            .map((t) => PeriodModel.fromJson(t))
            .toList();

             if (periods!.isNotEmpty) {
          dropDownValue = periods![0].name!;
        }

        Logger().e('PERIODS ARE ${periods}');
        emit(GetPeriodsSuccessState());
      },
      onFailed: (myErrors) {
        Logger().e('ERROR ${myErrors}');
        emit(GetPeriodsFailedState());
      },
    );
  }

}

abstract class GetPeriodsStates {}

class GetPeriodsinitialState extends GetPeriodsStates {}

class GetPeriodsLoadingState extends GetPeriodsStates {}

class GetPeriodsSuccessState extends GetPeriodsStates {}

class GetPeriodsFailedState extends GetPeriodsStates {}

class GetPeriodsChangeMenuItemState extends GetPeriodsStates {}