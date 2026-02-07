import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:taskify/src/config/di/injections.dart';
import 'package:taskify/src/features/auth/presentation/controllers/auth_controller.dart';

class MultiProviders {
  static List<SingleChildWidget> list = [
    ChangeNotifierProvider(create: (context) => sl<AuthController>()),
  ];
}
