import 'dart:ui';

Color myBrownColor = const Color(0xFF995D42);
Color myGrey = const Color(0xFFA8A8A9);
Color myDarkGrey = const Color(0xFF676767);
Color myRed = const Color(0xFFFF4B26);
Color myBlue = const Color(0xff59C9ED);
Color myStarColor = const Color(0xFFFFA903);
Color myLightRed = const Color(0xFFEB5757);
Color green = const Color(0xFF4AC76D);
Color myLightGrey = const Color(0xFFDDDDDD);
Color myGold = const Color(0xFFF0A91D);
Color waterColorWithOpacity = const Color(0xff59C9ED).withOpacity(0.3);
Color greenWithOpasity = const Color(0xff65EB59).withOpacity(0.3);
Color black = const Color(0xff000000);
Color waterColor = const Color(0xff59C9ED);

Color whiteColor = const Color(0xffFFFFFF);
Color sleepColor = const Color(0xff8A2BE2);
Color calorieColor = const Color(0xffFFA500);
Color proteinColor = const Color(0xFFB0C4DE);

const splashScreen = "assets/logo/splashscreen.png";
const appleLogo = "assets/logo/apple.png";
const googleLogo = "assets/logo/google.png";
const facebookLogo = "assets/logo/facebook.png";
const userProfile = "assets/logo/user.webp";
const goodMorning = "assets/animation/goodmorning.json";
const goodAfternoon = "assets/animation/goodafternoon.json";
const goodEvening = "assets/animation/goodevening.json";

// class Utils {
//   static final messengerKey =
//       GlobalKey<ScaffoldMessengerState>();
//   static showSnackBar(String? text) {
//     if (text != null) return;

//     final snackBar = SnackBar(
//       content: Text(text!),
//       duration: const Duration(seconds: 3),

     
//     );
//      messengerKey.cureentState!
//       ..removeCureentSnackBar()
//       ..showSnackBar(snackBar);
//   }


// }

String getFirstandLastNameInitals(String fullName) {
  if (fullName.isEmpty) {
    return 'N/A';
  }
  if (fullName.split(' ').length == 1) {
    return fullName[0];
  }
  List<String> name = fullName.split(' ');
  return name[0][0] + name[1][0];
}
