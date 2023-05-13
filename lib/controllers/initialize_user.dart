import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nouns_flutter/controllers/auth_controller.dart';

class InitializeUserController extends GetxController {
  final _username = ''.obs;
  final _country = ''.obs;
  final _selectedAvatar = ''.obs;
  final _selectedCharacter = ''.obs;
  final _email = ''.obs;
  final _password = ''.obs;

  final _loading = false.obs;
  Logger logger = Get.find();
//TODO add email and password as filds of this clas
  Future<AuthResult> registerUser() async{
    logger.i('Registering user...');
    //for now just use the email and password method, later integrate more
    var result = await Get.find<AuthController>().signUpWithGoogle(
   
      username: username,
      avatar: selectedAvatar,
      character: selectedCharacter,
      country: country);

    return result;
  }

  set username(String value) => _username.value = value;
  String get username => _username.value;

  set email(String value) => _email.value = value;
  String get email => _email.value;

  set password(String value) => _password.value = value;
  String get password => _password.value;

  set country(String value) => _country.value = value;
  String get country => _country.value;

  set selectedCharacter(String value) => _selectedCharacter.value = value;
  String get selectedCharacter => _selectedCharacter.value;

  set selectedAvatar(String value) => _selectedAvatar.value = value;
  String get selectedAvatar => _selectedAvatar.value;

   set loading(bool value) => _loading.value = value;
  bool get loading => _loading.value;
}
