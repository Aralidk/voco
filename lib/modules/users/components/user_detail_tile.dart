import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UserTile extends StatelessWidget {
  final UserModel user;

  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4.0,
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(user.avatar!),
          ),
          title: Text(
            '${user.firstName} ${user.lastName}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text("Email:${user.email}"),
          trailing: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}