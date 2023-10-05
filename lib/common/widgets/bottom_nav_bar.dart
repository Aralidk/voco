import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voco/modules/login/view/login_view.dart';

import '../../modules/login/notifier/auth_notifier.dart';

class AppBottomNavBar extends ConsumerWidget {
  AppBottomNavBar({
    super.key,
  });

  final logController = ChangeNotifierProvider((ref) => Auth());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
      selectedIconTheme: const IconThemeData(
        color: Colors.indigo
      ),
      selectedLabelStyle: TextStyle(
        color: Colors.blue[900]
      ),
      currentIndex: 1,
      onTap: (index) async {
        if (index == 2) {
          ref.read(logController).logout().then((value) => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage())));
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
    );
  }
}
