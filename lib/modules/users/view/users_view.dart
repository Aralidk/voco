import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voco/modules/login/view/login_view.dart';
import 'package:voco/modules/users/components/user_detail_tile.dart';
import 'package:voco/modules/users/models/user_list_model.dart';
import 'package:voco/modules/users/notifier/users_notifier.dart';

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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          UserListBody(read: read, watch: watch),
          ElevatedButton(
              onPressed: () {
                read.updatePage();
              },
              child: const Text("Daha Fazla")),
          const SizedBox(height: 30.0),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) async {
          if (index == 2) {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            await preferences.remove("token");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
          }
        },
        items: const [
          BottomNavigationBarItem(label: "Profil", icon: Icon(Icons.person)),
          BottomNavigationBarItem(label: "Anasayfa", icon: Icon(Icons.home)),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: "Çıkış Yap",
          )
        ],
      ),
    );
  }
}

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
