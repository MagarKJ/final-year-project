import "dart:developer";


import "package:final_project/controller/bloc/paymentbloc/bloc/payment_bloc_bloc.dart";
import "package:final_project/firebase_api.dart";
import "package:final_project/controller/bloc/addFood/add_food_bloc.dart";
import "package:final_project/controller/bloc/analytics/analytics_bloc.dart";
import "package:final_project/controller/bloc/fogrotpassword/forpas_bloc.dart";
import "package:final_project/controller/bloc/login/login_bloc.dart";
import "package:final_project/controller/bloc/notification/notification_bloc.dart";
import "package:final_project/view/screens/splashscreen.dart";
import "package:firebase_messaging/firebase_messaging.dart";

import 'package:timezone/data/latest_all.dart' as tz;
import "package:final_project/controller/bloc/profile/profile_bloc.dart";
import "package:final_project/controller/bloc/signup/signup_bloc.dart";
import "package:final_project/controller/bloc/home/home_page_bloc.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get/get.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await AndroidAlarmManager.initialize();
  await Firebase.initializeApp();
  FireBaseAPi().initLocalNotifications();
  tz.initializeTimeZones();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

//top level function huna parcaha kina ki background ma message aauda chai top level function ma nai handle garna parxa
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  log("Handling a background message: ${message.messageId}");
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
        BlocProvider<NotificationBloc>(create: (context) => NotificationBloc()
            // ..add(NotificationLoadedEvent()
            // ),
            ),
        BlocProvider<AddFoodBloc>(
          create: (context) => AddFoodBloc(),
        ),
        BlocProvider<AnalyticsBloc>(
          create: (context) => AnalyticsBloc(),
        ),
        BlocProvider<PaymentBlocBloc>(
          create: (context) => PaymentBlocBloc(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Get Fit",
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
