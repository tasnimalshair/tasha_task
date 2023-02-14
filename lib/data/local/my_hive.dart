import 'package:hive/hive.dart';
import 'package:tasha_task/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyHive {
  static late Box box;
  static const _user = 'user';
  // annotations
  //save object async
  //remove object nullable

  static Future<void> init() async {
    await Hive.initFlutter();
    box = await Hive.openBox(_user);
  }

  static Future<int> saveObject(LoginModel userModel) async {
    try {
      return await box.add(userModel);
    } catch (error) {
      return -1;
    }
  }

  static Future<void>? removeObject(LoginModel userModel) async {
    try {
      await box.delete(userModel);
    } catch (error) {
      print('Deleted Failed');
    }
  }

  static LoginModel? getUser(int index) {
    try {
      box.getAt(index);
    } catch (error) {
      return null;
    }
  }

  static void updateUser(
      String firstName,
      String lastName,
      int addressID,
      String addressDetails,
      String mobileNumber,
      int gender,
      String birthDate,
      String photo
      ){
    getUser(0)!.userVM!.firstName = firstName;
    getUser(0)!.userVM!.lastName = lastName;
    getUser(0)!.userVM!.addressID = addressID;
    getUser(0)!.userVM!.addressDetails = addressDetails;
    getUser(0)!.userVM!.mobileNumber = mobileNumber;
    getUser(0)!.userVM!.gender = gender;
    getUser(0)!.userVM!.birthDate = birthDate;
    getUser(0)!.userVM!.photo = photo;
  }

   static dynamic getData(key){
    try{
      box.get(key);
    }catch (error){
      return 'Key not found';
    }
   }
}
