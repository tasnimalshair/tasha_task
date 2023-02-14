import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:tasha_task/models/advertisement_model.dart';
import 'package:tasha_task/models/section_price_model.dart';
import 'package:tasha_task/services/dio_helper.dart';
import 'package:tasha_task/services/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetSectionPricesCubit extends Cubit<GetSectionPricesStates> {
  GetSectionPricesCubit() : super(GetSectionPricesinitialState());

  static GetSectionPricesCubit get(context) =>
      BlocProvider.of<GetSectionPricesCubit>(context);

  List<SectionPriceModel>? sectionPrices;

  void getSectionPrices({required int sectionID}) {
    emit(GetSectionPricesLoadingState());
    DioHelper.getData(
      url: GET_SECTION_PRICES,
      query: {'_SectionID': sectionID},
      onSuccess: (response) {
        sectionPrices = (response.data['data'] as List)
            .map((t) => SectionPriceModel.fromJson(t))
            .toList();

        Logger().e('ADVRTISEMENTS ARE ${sectionPrices}');
        emit(GetSectionPricesSuccessState());
      },
      onFailed: (myErrors) {
        Logger().e('ERROR ${myErrors}');
        emit(GetSectionPricesFailedState());
      },
    );
  }
}

abstract class GetSectionPricesStates {}

class GetSectionPricesinitialState extends GetSectionPricesStates {}

class GetSectionPricesLoadingState extends GetSectionPricesStates {}

class GetSectionPricesSuccessState extends GetSectionPricesStates {}

class GetSectionPricesFailedState extends GetSectionPricesStates {}
