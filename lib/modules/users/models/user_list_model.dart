import 'package:voco/modules/users/models/support_model.dart';
import 'package:voco/modules/users/models/user_model.dart';

class UserListModel {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<UserModel>? userModel;
  Support? support;

  UserListModel(
      {this.page,
        this.perPage,
        this.total,
        this.totalPages,
        this.userModel,
        this.support});

  UserListModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['data'] != null) {
      userModel = <UserModel>[];
      json['data'].forEach((v) {
        userModel!.add(UserModel.fromJson(v));
      });
    }
    support =
    json['support'] != null ? Support.fromJson(json['support']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['per_page'] = perPage;
    data['total'] = total;
    data['total_pages'] = totalPages;
    if (userModel != null) {
      data['data'] = userModel!.map((v) => v.toJson()).toList();
    }
    if (support != null) {
      data['support'] = support!.toJson();
    }
    return data;
  }
}

