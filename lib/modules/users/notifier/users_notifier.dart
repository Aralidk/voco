import 'package:flutter/material.dart';
import 'package:voco/modules/users/controller/user_controller.dart';
import 'package:voco/modules/users/models/user_list_model.dart';

class UserNotifier extends ChangeNotifier {
  bool isLoading = false;
  UserListModel userListModel = UserListModel(userModel: []);
  int page = 1;
  int pageSize = 8;

  Future<UserListModel> getUsers() async {
    isLoading = true;
    await UserController.getUserList(page, pageSize).then((response) {
      isLoading = false;
      if (userListModel.userModel!.isNotEmpty &&
          userListModel.userModel!.first.id != response.userModel!.first.id) {
        for (var element in response.userModel!) {
          userListModel.userModel!.add(element);
        }
        userListModel.page = response.page;
      } else {
        userListModel = response;
      }
    });
    return userListModel;
  }

  void updatePage() {
    page += 1;
    notifyListeners();
    getUsers();
  }
}
