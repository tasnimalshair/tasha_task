import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:http/io_client.dart';
import 'package:logger/logger.dart';
import 'package:tasha_task/data/local/my_hive.dart';
import 'package:tasha_task/models/advertisement_model.dart';
import 'package:tasha_task/models/area_model.dart';
import 'package:tasha_task/models/confirm_mobile_model.dart';
import 'package:tasha_task/models/country_model.dart';
import 'package:tasha_task/models/register_model.dart';
import 'package:tasha_task/models/section_model.dart';
import 'package:tasha_task/models/services_model.dart';
import 'package:tasha_task/models/specificResturantModel.dart';
import 'package:tasha_task/models/story_model.dart';
import 'package:tasha_task/screens/app_screen.dart';
import 'package:tasha_task/screens/bottomNavigationScreens/home.dart';
import 'package:tasha_task/screens/bottomNavigationScreens/near_places.dart';
import 'package:tasha_task/screens/bottomNavigationScreens/profile.dart';
import 'package:tasha_task/screens/bottomNavigationScreens/reservations.dart';
import 'package:tasha_task/screens/drawer_pages/contactWithUs_screen.dart';
import 'package:tasha_task/screens/drawer_pages/howAreWe_scree.dart';
import 'package:tasha_task/screens/drawer_pages/language_screen.dart';
import 'package:tasha_task/screens/drawer_pages/manager_request_screen.dart';
import 'package:tasha_task/screens/services/chalets.dart';
import 'package:tasha_task/screens/start_screen.dart';
import 'package:tasha_task/services/dio_helper.dart';
import 'package:tasha_task/services/end_points.dart';
import 'package:tasha_task/services/states.dart';
import 'package:tasha_task/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:tasha_task/shared/components.dart';

import 'package:tasha_task/shared/constants.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);
  LoginModel? loginModel;

  void Login(
      {required String username,
      required String password,
      required BuildContext context}) {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);

    emit(AppLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'userName': username,
        'password': password,
        'loginSource': 'b',
        'email': '',
        'fcmToken': ''
      },
      onSuccess: (response) {
        loginModel = LoginModel.fromJson(response.data);
        MyHive.saveObject(loginModel!);
        navigateWithReplacement(context: context, widget:StartScreen());
        emit(AppSuccessState(loginModel!));
      },
      onFailed: (myError) {
        print(myError.toString());
        emit(AppFailedState(myError.toString()));
      },
    );
  }

  RegisterModel? registerModel;

  void register(
      {required String addressDetails,
      required String addressID,
      required String birthDate,
      required String bUserName,
      required String firstName,
      required int gender,
      required String idno,
      required String lastName,
      required String mobileNumber,
      required String password}) {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);

    emit(AppRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: FormData.fromMap({
        'AddressDetails': addressDetails,
        'AddressID': addressID,
        'BirthDate': birthDate,
        'BUserName': bUserName,
        'FirstName': firstName,
        'Gender': gender,
        'IDNO': idno,
        'LastName': lastName,
        'MobileNumber': mobileNumber,
        'Password': password,
        'FCMToken': 'proident fugiat'
      }),
      onSuccess: (response) {
        registerModel = RegisterModel.fromJson(response.data);
        Logger().e('Success');
        emit(AppRegisterSuccessState(registerModel!));
      },
      onFailed: (myError) {
        print(myError.toString());
        // Logger().e(myError.response?.data);
        // Logger().e(myError.message);
        // Logger().e(myError.response?.statusCode);
        Logger().e('ERROR');
        emit(AppRegisterFailedState(myError.toString()));
      },
    );
  }

  void loginWithFb({
    required String accessToken,
  }) {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);

    emit(AppLoginFbLoadingState());
    DioHelper.getData(
      url: LOGIN_FB,
      query: {
        'accessToken': accessToken,
      },
      onSuccess: (response) {
        loginModel = LoginModel.fromJson(response.data);
        emit(AppLoginFbSuccessState(loginModel!));
      },
      onFailed: (myError) {
        print(myError.toString());
        emit(AppLoginFbFailedState(myError.toString()));
      },
    );
  }

  void loginWithGmail({
    required String idToken,
  }) {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);

    emit(AppLoginGmailLoadingState());
    DioHelper.getData(
      url: LOGIN_GMAIL,
      query: {
        'IdToken': idToken,
      },
      onSuccess: (response) {
        loginModel = LoginModel.fromJson(response.data);
        emit(AppLoginGmailSuccessState(loginModel!));
      },
      onFailed: (myError) {
        print(myError.toString());
        emit(AppLoginGmailFailedState(myError.toString()));
      },
    );
  }

  // List<String> items = ['غزة', 'رفح', 'دير البلح', 'خانيونس', 'بيت لاهيا'];

  var dropDownValue;

 void onChangeItem(value) {
    dropDownValue = value;
    emit(AppChangeMenuItemState());
  }
 
  Map<String, dynamic> registerData = {};

  void addRegisterData(
      {required int id,
      required String confirmCode,
      required String username,
      required String password}) {
    Logger().e('addRegisterData!!');
    registerData.addAll({
      'ID': id,
      'ConfirmationCode': confirmCode,
      'userName': username,
      'password': password
    });
    Logger().e(registerData);
    emit(AppSuccessMapState());
  }

  ConfirmModel? confirmModel;

  void confirmMobile({required int id, required String confirmationCode}) {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);

    emit(AppConfirmLoadingState());
    DioHelper.putData(
      url: CONFIRM_MOBILE,
      query: {'ID': id, 'ConfirmationCode': confirmationCode},
      onSuccess: (response) {
        confirmModel = ConfirmModel.fromJson(response.data);
        emit(AppConfirmSuccessState(confirmModel!));
      },
      onFailed: (myError) {
        print(myError.toString());
        emit(AppConfirmFailedState(myError.toString()));
      },
    );
  }

  List<AreaModel>? countries;

  void getCountries() {
    DioHelper.getData(
      url: GET_COUNTRIES,
      query: {'CountryID': 57, 'Governorate': 1, 'GovernorateOnly': true},
      onSuccess: (response) {
        countries = (response.data['data'] as List)
            .map((x) => AreaModel.fromJson(x))
            .toList();

        if (countries!.isNotEmpty) {
          dropDownValue = countries![0].iD;
        }

        // Logger().e('COUNTRIES ARE ${countries}');
        emit(AppGetCountriesSuccessState());
      },
      onFailed: (myErrors) {
        Logger().e('ERROR ${myErrors}');
        emit(AppGetCountriesFailedState(myErrors.toString()));
      },
    );
  }

  var currentIndex = 0;
 late ZoomDrawerController drawerControllerIn;
  List<Widget> bottoNavigationWidgets = [
    HomeScreen(),
    ReservationsScreen(),
    NearPlacesScreen(),
    ProfileScreen()
  ];

  void changeBottomNavigationBarIndex(value) {
    currentIndex = value;
    emit(AppChangeBottomNavigationBarState());
  }

  List<StoryModel>? stories;

  void getStories() {
    DioHelper.getData(
      url: GET_STORIES,
      onSuccess: (response) {
        Logger().e('RV iS ${response.data['rv']}');
        // stories = (response.data['data'] as List)
        //     .map((x) => (x['Details'] as List))
        //   .map<StoryModel>((t) =>  StoryModel.fromJson(t[0]))
        //     .toList();

        Logger().e('stories ARE ${stories}');
        emit(AppGetStoriesSuccessState());
      },
      onFailed: (myErrors) {
        Logger().e('ERROR ${myErrors}');
        emit(AppGetStoriesFailedState(myErrors.toString()));
      },
    );
  }

  int pageIndex = 0;
  void changeIndicatorIndex(value) {
    pageIndex = value;
    emit(AppChangeIndicatorIndexState());
  }

  List list = [
    {'text': 'من نحن', 'navigateTo': HowAreWeScreen()},
    {'text': 'تواصل معنا', 'navigateTo': ContactWithUsScreen()},
    {'text': 'طلب صاحب منشأة', 'navigateTo': ManagerRequestScreen()},
    {'text': 'اللغة', 'navigateTo': LanguageScreen()},
  ];

  // SpecificResturantModel? specificResturantModel;

  // void getSpecificResturan({required int sectioId}) {
  //   emit(AppGetSpecificResturantLoadingState());
  //   DioHelper.getData(
  //     url: GET_SPECIFIC_RESTURANT,
  //     query: {'SectionTypeID': sectioId, 'OrderByNearest': false},
  //     onSuccess: (response) {
  //       specificResturantModel = response.data;
  //       emit(AppGetSpecificResturantSuccessState());
  //     },
  //     onFailed: (myErrors) {
  //       Logger().e('ERROR ${myErrors}');
  //       emit(AppSpecificResturantFailedState(myErrors.toString()));
  //     },
  //   );
  // }

  bool isFav = false;
  void changeFav() {
    isFav = !isFav;
    emit(AppChangeFavState());
  }
}
