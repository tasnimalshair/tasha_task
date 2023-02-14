import 'package:tasha_task/services/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckBoxCubit extends Cubit<CheckState> {
  static CheckBoxCubit get(context) => BlocProvider.of<CheckBoxCubit>(context);

  var checkValue = false;

  CheckBoxCubit() : super(CheckInitialState());
  void ChangeCheckValue(value) {
    checkValue = value;
    emit(AppChangeCheckValueState());
  }

  var selectedRadio;
  // var mailRadio = 'mail';
  // var femailRadio = 'female';
  var finalRadio;

  void changeRadio(value) {
    selectedRadio = value;
    emit(AppChangeSelectedRadioState());
  }
}

abstract class CheckState {}

class CheckInitialState extends CheckState {}

class AppChangeCheckValueState extends CheckState {}

class AppChangeSelectedRadioState extends CheckState {}
