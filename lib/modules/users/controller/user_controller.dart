import 'dart:convert';
import 'package:http/http.dart';
import 'package:voco/modules/users/models/user_list_model.dart';

class UserController{

  static Future<UserListModel> getUserList(
      int page, int pageSize) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
    };
    var url = Uri.parse("https://reqres.in/api/users?page=$page&per_page=$pageSize");

    var response = await get(url, headers: headers);
    var responseBody = json.decode(utf8.decode(response.bodyBytes));
    if(response.statusCode == 200){
      UserListModel userListModel = UserListModel.fromJson(responseBody);
      return userListModel;
    }
    else{
      return responseBody["error"];
    }
  }
}