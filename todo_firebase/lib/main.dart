import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_firebase/common/show_model.dart';
import 'package:todo_firebase/firebase_options.dart';
import 'package:todo_firebase/view/home_page.dart';
import 'package:todo_firebase/widget/card_todo_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Todo',
        theme: ThemeData(),
        home: HomePage(),
      ),
    ),
  );
}
