import 'package:tasha_task/models/area_model.dart';
import 'package:tasha_task/models/confirm_mobile_model.dart';
import 'package:tasha_task/models/country_model.dart';
import 'package:tasha_task/models/register_model.dart';
import 'package:tasha_task/models/user_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppLoadingState extends AppStates {}

class AppSuccessState extends AppStates {
  final LoginModel model;
  AppSuccessState(this.model);
}

class AppFailedState extends AppStates {
  final String error;
  AppFailedState(this.error);
}

class AppRegisterLoadingState extends AppStates {}

class AppRegisterSuccessState extends AppStates {
  final RegisterModel model;
  AppRegisterSuccessState(this.model);
}

class AppRegisterFailedState extends AppStates {
  final String error;
  AppRegisterFailedState(this.error);
}

class AppLoginFbLoadingState extends AppStates {}

class AppLoginFbSuccessState extends AppStates {
  final LoginModel model;
  AppLoginFbSuccessState(this.model);
}

class AppLoginFbFailedState extends AppStates {
  final String error;
  AppLoginFbFailedState(this.error);
}

class AppLoginGmailLoadingState extends AppStates {}

class AppLoginGmailSuccessState extends AppStates {
  final LoginModel model;
  AppLoginGmailSuccessState(this.model);
}

class AppLoginGmailFailedState extends AppStates {
  final String error;
  AppLoginGmailFailedState(this.error);
}

class AppChangeMenuItemState extends AppStates {}

class AppConfirmLoadingState extends AppStates {}

class AppConfirmSuccessState extends AppStates {
  final ConfirmModel model;
  AppConfirmSuccessState(this.model);
}

class AppConfirmFailedState extends AppStates {
  final String error;
  AppConfirmFailedState(this.error);
}

class AppSuccessMapState extends AppStates {}

class AppGetCountriesSuccessState extends AppStates {}

class AppGetCountriesFailedState extends AppStates {
  final String error;
  AppGetCountriesFailedState(this.error);
}

class AppChangeBottomNavigationBarState extends AppStates {}

class AppGetStoriesSuccessState extends AppStates {}

class AppGetStoriesFailedState extends AppStates {
  final String error;
  AppGetStoriesFailedState(this.error);
}

class AppChangeIndicatorIndexState extends AppStates {}

class AppGetSectionsSuccessState extends AppStates {}

class AppGetSectionsLoadingState extends AppStates {}

class AppGetSectionsFailedState extends AppStates {
  final String error;
  AppGetSectionsFailedState(this.error);
}

class AppGetAdvertisementsLoadingState extends AppStates {}


class AppGetAdvertisementsSuccessState extends AppStates {}

class AppGetAdvertisementsFailedState extends AppStates {
  final String error;
  AppGetAdvertisementsFailedState(this.error);
}

class AppGetServicesLoadingState extends AppStates {}

class AppGetServicesSuccessState extends AppStates {}

class AppGetServicesFailedState extends AppStates {
  final String error;
  AppGetServicesFailedState(this.error);
}


class AppGetSpecificResturantLoadingState extends AppStates {}

class AppGetSpecificResturantSuccessState extends AppStates {}

class AppSpecificResturantFailedState extends AppStates {
  final String error;
  AppSpecificResturantFailedState(this.error);
}

class AppIsClickedState extends AppStates {}

class AppChangeFavState extends AppStates {}

