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

class GetMenusCubit extends Cubit<GetMenusStates> {
  GetMenusCubit() : super(GetMenusinitialState());

  static GetMenusCubit get(context) => BlocProvider.of<GetMenusCubit>(context);

  List<MenuModel>? menus;
  void getMenus({required int sectionID}) {
    emit(GetMenusLoadingState());
    DioHelper.getData(
      url: GET_MENU,
      query: {'SectionID': sectionID},
      onSuccess: (response) {
        // Logger().e('RV iS ${response.data['rv']}');
        menus = (response.data['data'] as List)
            .map((t) => MenuModel.fromJson(t))
            .toList();

        Logger().e('MENUS ARE ${menus}');
        emit(GetMenusSuccessState());
      },
      onFailed: (myErrors) {
        Logger().e('ERROR ${myErrors}');
        emit(GetMenusFailedState());
      },
    );
  }
}

abstract class GetMenusStates {}

class GetMenusinitialState extends GetMenusStates {}

class GetMenusLoadingState extends GetMenusStates {}

class GetMenusSuccessState extends GetMenusStates {}

class GetMenusFailedState extends GetMenusStates {}
