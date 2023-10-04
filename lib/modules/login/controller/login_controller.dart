import 'dart:convert';
import 'package:http/http.dart';

class LoginController{
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
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
      return responseBody;
    }
    else{
      return responseBody;
    }
  }
}