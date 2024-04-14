import "package:final_project/controller/bloc/fogrotpassword/bloc/forpas_bloc.dart";
import "package:final_project/controller/bloc/login/login_bloc.dart";
import "package:final_project/controller/bloc/profile/bloc/profile_bloc.dart";
import "package:final_project/controller/bloc/signup/signup_bloc.dart";
import "package:final_project/controller/bloc/home/home_page_bloc.dart";
import "package:final_project/view/screens/splashscreen.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get/get.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //appbar mathi ko status bar lai transparent banauna
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    //MultiBlocProvider use gareko kina ki multiple bloc use garna lai
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<SignupBloc>(
          create: (context) => SignupBloc(),
        ),
        BlocProvider<HomePageBloc>(
          create: (context) => HomePageBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider<ForpasBloc>(
          create: (context) => ForpasBloc(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Final Year Project",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Scaffold(
          body: SplashScreen(),
        ),
      ),
    );
  }
}
