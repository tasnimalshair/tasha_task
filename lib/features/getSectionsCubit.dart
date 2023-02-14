import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:tasha_task/models/advertisement_model.dart';
import 'package:tasha_task/models/section_model.dart';
import 'package:tasha_task/models/services_model.dart';
import 'package:tasha_task/screens/services/chalets.dart';
import 'package:tasha_task/services/dio_helper.dart';
import 'package:tasha_task/services/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetSectionsCubit extends Cubit<GetSectionsStates> {
  GetSectionsCubit() : super(GetSectionsinitialState());

  static GetSectionsCubit get(context) =>
      BlocProvider.of<GetSectionsCubit>(context);

  // List widgets = [ChaletsScreen(), HotelsScreen(), ResturantsScreen()];
  var dropDownValue;
  List<SectionModel>? sections;
  List<String>? sectionsTitles;

  // sections at home <الشاليهات الفنادق المطاعم>
  void getSections() {
    emit(GetSectionsLoadingState());
    DioHelper.getData(
      url: GET_SECTIONS,
      onSuccess: (response) {
        Logger().e('RV iS ${response.data['rv']}');
        sections = (response.data['data'] as List)
            .map((t) => SectionModel.fromJson(t))
            .toList();



        if (sections!.isNotEmpty) {
          dropDownValue = sections![0].iD;
        }
        emit(GetSectionsSuccessState());
      },
      onFailed: (myErrors) {
        Logger().e('ERROR ${myErrors}');
        emit(GetSectionsFailedState());
      },
    );
  }

  void onChangeItem(value) {
    dropDownValue = value;
    emit(ChangeMenuItemState());
  }
}

abstract class GetSectionsStates {}

class GetSectionsinitialState extends GetSectionsStates {}

class GetSectionsLoadingState extends GetSectionsStates {}

class GetSectionsSuccessState extends GetSectionsStates {}

class GetSectionsFailedState extends GetSectionsStates {}

class ChangeMenuItemState extends GetSectionsStates {}
