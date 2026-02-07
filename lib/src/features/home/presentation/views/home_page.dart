import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:taskify/src/config/di/injections.dart';
import 'package:taskify/src/config/router/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(SolarIconsOutline.logout),
            onPressed: () {
              sl<FirebaseAuth>().signOut();
              context.go(AppRoutes.login);
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Home', style: Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }
}
