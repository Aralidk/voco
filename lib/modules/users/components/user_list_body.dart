import 'package:flutter/material.dart';
import 'package:voco/modules/users/components/user_detail_tile.dart';

import '../models/user_list_model.dart';
import '../notifier/users_notifier.dart';

class UserListBody extends StatelessWidget {
  const UserListBody({
    super.key,
    required this.read,
    required this.watch,
  });

  final UserNotifier read;
  final UserNotifier watch;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserListModel>(
        future: read.getUsers(),
        builder: (BuildContext context, snapshot) {
          if (!watch.isLoading) {
            return Expanded(
              child: ListView.builder(
                itemCount: snapshot.data?.userModel?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return UserTile(user: snapshot.data!.userModel![index]);
                },
              ),
            );
          } else if (watch.userListModel.userModel!.isEmpty &&
              !watch.isLoading) {
            return const Center(child: Text("Bağlantı Kurulamadı"));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}