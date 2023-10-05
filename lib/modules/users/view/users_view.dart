import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voco/common/styles/button_Styles.dart';
import 'package:voco/modules/users/notifier/users_notifier.dart';
import '../../../common/widgets/bottom_nav_bar.dart';
import '../components/user_list_body.dart';

final userNotifier = ChangeNotifierProvider((ref) => UserNotifier());

class UsersView extends ConsumerWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(userNotifier);
    final read = ref.read(userNotifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 30.0),
          const Text("Kullanıcılar",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.indigo)),
          UserListBody(read: read, watch: watch),
          watch.page == watch.userListModel.totalPages
              ? const SizedBox()
              : ElevatedButton(
                  onPressed: () {
                    read.updatePage();
                  },
              style: roundedIndigoButton(),
                  child: const Text("Daha Fazla")),
          const SizedBox(height: 30.0),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(),
    );
  }
}



