import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController{
  static Future<String?> login(
      String email, String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      'Content-type': 'application/json',
    };
    var url =
    Uri.parse("https://reqres.in/api/login");
    var body = json.encode({
      "email" : email,
      "password": password
    });
    var response = await post(url, body: body, headers: headers);
    var responseBody = json.decode(utf8.decode(response.bodyBytes));
    if(response.statusCode == 200){
      print("here");
      print(responseBody["token"]);
      preferences.setString("token", responseBody["token"]);
    }
    else{
      print(responseBody);
      return responseBody["error"];
    }
  }
}