import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:toastification/toastification.dart';

class UserMenu extends StatelessWidget {
  const UserMenu({super.key});

  String colorToHex(Color color) {
    return color.intValue.toRadixString(16).padRight(8, '0').substring(2);
  }

  @override
  Widget build(BuildContext context) {
    final hexColor = colorToHex(Theme.of(context).primaryColor);

    return MenuAnchor(
      builder: (context, controller, child) {
        return GestureDetector(
          onTap: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(
              fadeInDuration: const Duration(milliseconds: 500),
              fadeOutDuration: const Duration(milliseconds: 500),
              imageUrl:
                  "https://api.dicebear.com/9.x/fun-emoji/svg?seed=Brian&backgroundColor=$hexColor",
              width: 50,
              height: 50,
              fit: BoxFit.fill,
            ),
          ),
        );
      },
      menuChildren: [
        MenuItemButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, '/login');
          },
          child: Row(
            children: [
              Icon(Icons.logout, color: Colors.red),
              SizedBox(width: 10),
              Text(translate("log-out"), style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
    );
  }
}
