import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskify/firebase_options.dart';
import 'package:taskify/src/config/di/injections.dart';
import 'package:taskify/src/config/router/app_router_config.dart';
import 'package:taskify/src/config/styles/app_theme.dart';
import 'package:taskify/src/core/utils/multi_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initInjections();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: MultiProviders.list,
      child: MaterialApp.router(
        title: 'Taskify',
        theme: AppTheme.light,
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouterConfig.router,
      ),
    );
  }
}
