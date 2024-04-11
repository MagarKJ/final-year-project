import "package:final_project/controller/bloc/login/login_bloc.dart";
import "package:final_project/view/authentication/login.dart";
import "package:final_project/controller/bloc/signup/signup_bloc.dart";
import "package:final_project/view/authentication/signup.dart";
import "package:final_project/view/bottom_navigtion_bar.dart";
import "package:final_project/view/screens/homescreen.dart";
import "package:final_project/view/screens/splashscreen.dart";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get/get.dart";

//testing
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<SignupBloc>(
          create: (context) => SignupBloc(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Final Year Project",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Scaffold(
          body: LoginScreen(),
        ),
      ),
    );
  }
}
