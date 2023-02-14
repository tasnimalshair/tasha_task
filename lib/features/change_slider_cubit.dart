import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:tasha_task/services/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeSliderCubit extends Cubit<SliderStates> {
  static ChangeSliderCubit get(context) => BlocProvider.of<ChangeSliderCubit>(context);


  ChangeSliderCubit() : super(SliderInitialState());

  var sliderValue=SfRangeValues(20.0, 400.0);
  void changeSlider(value) {
    sliderValue = value;
    emit(ChangeSliderValueState());
  }
}

abstract class SliderStates {}

class SliderInitialState extends SliderStates {}

class ChangeSliderValueState extends SliderStates {}


