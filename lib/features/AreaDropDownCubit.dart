import 'package:tasha_task/services/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AreaDropDownCubit extends Cubit<AreaDropDownState> {
  AreaDropDownCubit() : super(AreaDropDownInitialState());

  static AreaDropDownCubit get(context) =>
      BlocProvider.of<AreaDropDownCubit>(context);

  var dropDownValue = '';

  void onChangeItem(value) {
    dropDownValue = value;
    emit(ChangeAreaDropDownState());
  }

  
}

abstract class AreaDropDownState {}

class AreaDropDownInitialState extends AreaDropDownState {}

class ChangeAreaDropDownState extends AreaDropDownState {}
