import 'package:shared_preferences/shared_preferences.dart';


class AuthController {
  static const String accessTokenKey = 'access-token';
  static String? accessToken;

  static Future<void> saveAccessToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   
    await sharedPreferences.setString(accessTokenKey, token);
    accessToken = token;
  }

}
