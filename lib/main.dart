import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/cubit/cubit.dart';
import 'package:quiz/modules/splash.dart';
import 'package:quiz/shared/local/local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCubit()..getTypeQuiz(),
      child: MaterialApp(
        title: 'Quiz App',
        theme: ThemeData(backgroundColor: Colors.white),
        debugShowCheckedModeBanner: false,
        home: const Splash(),
      ),
    );
  }
}
