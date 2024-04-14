
Map<String, String> getSignupDetails(
  String name,
  String email,
  String password,
  String confirmPassword,
) {
  return {
    'name': name.trim(),
    'email': email.trim(),
    'password': password.trim(),
    'confirmPassword': confirmPassword.trim(),
  };
}

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
