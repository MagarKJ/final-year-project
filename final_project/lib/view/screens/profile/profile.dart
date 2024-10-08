// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/controller/apis/api.dart';
import 'package:final_project/utils/global_variables.dart';
import 'package:final_project/utils/constants.dart';
import 'package:final_project/view/screens/medicalreport/pill_reminder.dart';
import 'package:final_project/view/screens/profile/image.dart';
import 'package:final_project/view/screens/profile/payemnt/esewa.dart';
import 'package:final_project/view/screens/profile/profile_editor.dart';
import 'package:final_project/view/screens/profile/purchasehistory.dart';
import 'package:final_project/widgets/test.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../widgets/custom_alert_dialog_box.dart';
import '../../../widgets/custom_titile.dart';
import '../../../widgets/terms_and_conditions.dart';
import '../../authentication/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<ProfilePage> {
  String? contact;
  int? isEmailVerified;
  bool? isRememberme;
  String? password;
  int? boardingCount;

  @override
  void initState() {
    // log('email splash bata aako $email');
    log('$imageBaseUrl/user-photos/$image');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email'); // Get the current contact value
    bool? isRememberme = prefs.getBool('rememberMe');
    String? password = prefs.getString('password');
    int? boardingCount = prefs.getInt('boardingCount');
    isRememberme = isRememberme;
    email = email;
    password = password;
    boardingCount = boardingCount;
    // log('email mathi $email');
    // log('password mathi $password');
    // log('isRememberme mathi $isRememberme');
    // log('boarding count mathi $boardingCount');

    await prefs.clear(); // Clear all data
    await GoogleSignIn().signOut();
    // await GoogleSignIn().disconnect();

    prefs.setBool('rememberMe', isRememberme ?? false);
    prefs.setString('email', email ?? '');
    prefs.setString('password', password ?? '');
    prefs.setInt('boardingCount', boardingCount ?? 0);
    // log('boarding count $boardingCount');
    // log('email tala $email');
    // log("${isRememberme}isRememberme clear data bara aako value");
    // log("$email email clear data bara aako value");
    // log("$password password clear data bara aako value");

    // log(email.toString() + "email");

    // print("Data cleared, contact and remember me retained.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        surfaceTintColor: whiteColor,
        automaticallyImplyLeading: false,
        title: const CustomTitle(
          fontSize: 25,
          isAppbar: true,
          title: "Profile",
        ),
        leading: null,
      ),
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.1,
              ),
              Stack(
                children: [
                  Container(
                    width: Get.width * 0.9,
                    padding: const EdgeInsets.only(
                      top: 10,
                      // bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: Get.height * 0.1),
                        Text(
                          name ?? 'Loading',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          email1 ?? 'N/A',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            // Navigate to the Learning Dashboard
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const EditYourProfile()));
                          },
                          title: const Text('My Information'),
                          leading: Icon(
                            Icons.person,
                            color: secondaryColor,
                          ), // Customize the icon
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: secondaryColor,
                          ),
                        ),
                        const Divider(
                          height: 0,
                        ),
                        ListTile(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              builder: (context) {
                                return Container(
                                  height: Get.height * 0.85,
                                  width: Get.width,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                    gradient: LinearGradient(
                                        colors: [
                                          Color(0xff7DDCE9),
                                          Colors.white
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter),
                                  ),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 20),
                                      Text(
                                        'Upgrade To Premium',
                                        style: GoogleFonts.inter(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Benifits',
                                        style: GoogleFonts.inter(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        'Upgrade to our premium subscription for unlimited',
                                        style: GoogleFonts.inter(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'access to exclusive features.',
                                        style: GoogleFonts.inter(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      ListTile(
                                        leading: const Icon(
                                          Icons.check_circle,
                                          size: 40,
                                          color:
                                              Color.fromARGB(255, 8, 31, 234),
                                        ),
                                        title: Text(
                                          'Step Counter : Unlock advanced step tracking features, access to historical step data.',
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        leading: const Icon(
                                          Icons.check_circle,
                                          size: 40,
                                          color:
                                              Color.fromARGB(255, 8, 31, 234),
                                        ),
                                        title: Text(
                                          'Add Premium Food : Add your own food detailed nutritional information for your meals.',
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        leading: const Icon(
                                          Icons.check_circle,
                                          size: 40,
                                          color:
                                              Color.fromARGB(255, 8, 31, 234),
                                        ),
                                        title: Text(
                                          'Analytics Step Counter Graph : Visualize your progress with detailed step count graphs,showing daily, weekly, and monthly trends to help you stay on track.',
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        leading: const Icon(
                                          Icons.check_circle,
                                          size: 40,
                                          color:
                                              Color.fromARGB(255, 8, 31, 234),
                                        ),
                                        title: Text(
                                          'Recommendation: Get personalized fitness and nutrition recommendations tailored to your activity levels and goals, helping you achieve better results faster.',
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        width: Get.width * 0.9,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child: ListTile(
                                          leading: const Icon(
                                            Icons.check_circle,
                                            size: 40,
                                            color:
                                                Color.fromARGB(255, 8, 31, 234),
                                          ),
                                          title: Text(
                                            'Buy Premium',
                                            style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          subtitle: const Text('Rs.1000'),
                                          trailing: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color.fromARGB(
                                                  255, 2, 2, 56),
                                            ),
                                            child: TextButton.icon(
                                                onPressed: null,
                                                label: Text(
                                                  'Best Value',
                                                  style: GoogleFonts.inter(
                                                      color: Colors.white),
                                                ),
                                                icon: const Icon(
                                                  Icons.star,
                                                  color: Colors.white,
                                                )),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      GestureDetector(
                                        onTap: () {
                                          Esewa esewa = Esewa();
                                          esewa.pay();
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          width: Get.width * 0.9,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.blue,
                                          ),
                                          child: Text(
                                            'Upgrade',
                                            style: GoogleFonts.inter(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          title: const Text('Go Premium'),
                          leading: Icon(Icons.workspace_premium_rounded,
                              color: secondaryColor), // Customize the icon
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: secondaryColor,
                          ),
                        ),
                        const Divider(
                          height: 0,
                        ),
                        ListTile(
                          onTap: () {
                            Get.to(() => PillReminder());
                          },
                          title: const Text('Reminders'),
                          leading: Icon(
                            Icons.alarm,
                            color: secondaryColor,
                          ), // Customize the icon
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: secondaryColor,
                          ),
                        ),
                        const Divider(
                          height: 0,
                        ),
                        ListTile(
                          onTap: () {
                            Get.to(() => const TermsandCondition());
                          },
                          title: const Text(
                            'Terms and conditions',
                          ),
                          leading: Icon(
                            Icons.sticky_note_2,
                            color: secondaryColor,
                          ), // Customize the icon
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: secondaryColor,
                          ),
                        ),
                        const Divider(
                          height: 0,
                        ),
                        ListTile(
                          onTap: () {
                            Get.to(() => const Purchasehistory());
                          },
                          title: const Text('Purchase History'),
                          leading: Icon(
                            Icons.history,
                            color: secondaryColor,
                          ), // Customize the icon
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: secondaryColor,
                          ),
                        ),
                        const Divider(
                          height: 0,
                        ),
                        ListTile(
                          onTap: () async {
                            // final prefs =
                            //     await SharedPreferences.getInstance();
                            customAlertBox(
                              context,
                              'Do you really want to Logout?',
                              'Yes',
                              () async {
                                // googleLogin == 1
                                //     ? await signout()
                                // :
                                await clearData();

                                Get.offAll(() => const LoginScreen());
                              },
                              'No',
                              () async {
                                Navigator.pop(context);
                              },
                            );
                          },
                          title: const Text(
                            'Logout',
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'inter',
                                fontWeight: FontWeight.w500),
                          ),
                          leading: Icon(
                            Icons.power_settings_new_sharp,
                            color: primaryColor,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: primaryColor,
                          ), // Customize the icon
                          // Customize the icon
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Transform.translate(
                      offset: const Offset(0, -70),
                      child: GestureDetector(
                        onTap: () => Get.to(() => const ProfileImage()),
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: image == null || image == ''
                              ? Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Text(
                                      getFirstandLastNameInitals(
                                          name.toString().toUpperCase()),
                                      style: TextStyle(
                                          color: whiteColor, fontSize: 76),
                                    ),
                                  ),
                                )
                              : CachedNetworkImage(
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    );
                                  },
                                  imageUrl: '$imageBaseUrl/user-photos/$image',
                                  placeholder: (context, url) => Image.asset(
                                    'assets/no_user.png',
                                    fit: BoxFit.fitHeight,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/no_user.png',
                                    fit: BoxFit.fitHeight,
                                  ),
                                  fit: BoxFit.fitHeight,
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
