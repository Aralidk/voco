import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voco/modules/login/controller/login_controller.dart';
import '../../users/view/users_view.dart';


class Auth extends ChangeNotifier {
  bool isLoading = false;
  String? token;

  void login(String email, String password, BuildContext context)  {
    isLoading = true;
    notifyListeners();
    LoginController.login(email, password).then((value) async {
      isLoading = false;
      notifyListeners();
      if(value.containsKey("token")){
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("token", value["token"]);
        token = value["token"];
        notifyListeners();
        Navigator.push(context, MaterialPageRoute(builder: (context) => const UsersView()));
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(value.values.first)),
        );
      }
    });
  }

  Future<bool> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("token");
    token = null;
    return true;
  }
}
