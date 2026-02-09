import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:taskify/src/features/auth/auth_injections.dart';
import 'package:taskify/src/features/boards/board_injections.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

  // Variables
  sl.registerSingleton<FirebaseAuth>(firebaseAuth);
  sl.registerSingleton<FirebaseFirestore>(firebaseFirestore);

  initAuthInjections();
  initBoardInjections();
}
