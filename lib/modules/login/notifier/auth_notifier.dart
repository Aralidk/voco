
import 'package:flutter/material.dart';
import 'package:voco/modules/login/controller/login_controller.dart';
import '../../users/view/users_view.dart';

class Auth extends ChangeNotifier {
  bool isLoading = false;

  void login(String email, String password, BuildContext context) {
    isLoading = true;
    notifyListeners();
    LoginController.login(email, password).then((value){
      isLoading = false;
      notifyListeners();
      if(value == null){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const UsersView()));
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(value)),
        );
      }
    });
  }
}
