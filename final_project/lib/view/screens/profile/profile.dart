// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/model/global_variables.dart';
import 'package:final_project/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../widgets/custom_alert_dialog_box.dart';
import '../../../widgets/custom_titile.dart';
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
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email =
        prefs.getString('email_address'); // Get the current contact value
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
    prefs.setString('email_address', email ?? '');
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
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => const Profile()));
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
                            // Navigate to the Learning Dashboard
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => const LearningDashboard(),
                            // ));
                          },
                          title: const Text('Learning Dashboard'),
                          leading: Icon(Icons.school,
                              color: secondaryColor), // Customize the icon
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: secondaryColor,
                          ),
                        ),
                        const Divider(
                          height: 0,
                        ),
                        // Add more ListTile items for other options as needed
                        // Example:
                        ListTile(
                          onTap: () {
                            // Navigate to My Downloads
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => const Downloads(),
                            // ));
                          },
                          title: const Text('My Downloads'),
                          leading: Icon(
                            Icons.download_rounded,
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
                        // ListTile(
                        //   onTap: () {
                        //     Get.to(
                        //       () => const StudyMaterials(),
                        //     );
                        //   },
                        //   title: const Text('Study Materials'),
                        //   leading: const Icon(
                        //     FontAwesomeIcons.bookOpenReader,
                        //   ), // Customize the icon
                        // ),
                        // const Divider(
                        //   height: 0,
                        // ),
                        // ListTile(
                        //   onTap: () {
                        //     Get.to(() => NotesPage());
                        //   },
                        //   title: const Text('Student Plan'),
                        //   leading: const Icon(
                        //     FontAwesomeIcons.noteSticky,
                        //   ), // Customize the icon
                        // ),

                        // const Divider(
                        //   height: 0,
                        // ),

                        const Divider(
                          height: 0,
                        ),
                        Visibility(
                          visible: Platform.isAndroid,
                          child: ListTile(
                            onTap: () {
                              // Navigate to Purchase History
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) => BlocProvider(
                              //     create: (context) => TransactionsCubit(),
                              //     child: const PurchaseHistory(),
                              //   ),
                              // ));
                            },
                            title: const Text('Purchase History'),
                            leading: Icon(
                              Icons.shopping_cart,
                              color: secondaryColor,
                            ), // Customize the icon
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: secondaryColor,
                            ),
                          ),
                        ),
                        const Divider(
                          height: 0,
                        ),
                        // ListTile(
                        //   onTap: () {
                        //     // Navigate to Assignments
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => BlocProvider(
                        //           create: (context) => AssignmentCubit(),
                        //           child: const Assignments(),
                        //         ),
                        //       ),
                        //     );
                        //   },
                        //   title: const Text('Assignments'),
                        //   leading: const Icon(Icons.assignment), // Customize the icon
                        // ),
                        // const Divider(
                        //   height: 0,
                        // ),
                        // ListTile(
                        //   onTap: () {
                        //     // Navigate to Assignments
                        //     Get.to(() => const ExamResults());
                        //   },
                        //   title: const Text('Exam Results'),
                        //   leading: const Icon(
                        //     FontAwesomeIcons.rankingStar,
                        //   ), // Customize the icon
                        // ),
                        const Divider(
                          height: 0,
                        ),
                        // ListTile(
                        //   onTap: () {
                        //     // Navigate to Assignments
                        //     Get.to(() => const SyllabusScreen());
                        //   },
                        //   title: const Text('Syllabus'),
                        //   leading: const Icon(
                        //     FontAwesomeIcons.bookOpen,
                        //   ), // Customize the icon
                        // ),
                        // const Divider(
                        //   height: 0,
                        // ),
                        // ListTile(
                        //   onTap: () {
                        //     // Navigate to Assignments
                        //     Get.to(() => BlocProvider(
                        //           create: (context) => CourseStatsCubit(),
                        //           child: StatsPage(),
                        //         ));
                        //   },
                        //   title: const Text('Course Stats'),
                        //   leading: const Icon(Icons.table_chart), // Customize the icon
                        // ),
                        // const Divider(
                        //   height: 0,
                        // ),
                        // ListTile(
                        //   onTap: () {
                        //     // Navigate to Assignments
                        //     Get.to(
                        //       () => BlocProvider(
                        //         create: (context) => UserActivityCubit(),
                        //         child: LoginHistoryPage(),
                        //       ),
                        //     );
                        //   },
                        //   title: const Text('Login History'),
                        //   leading: const Icon(
                        //     FontAwesomeIcons.timeline,
                        //   ), // Customize the icon
                        // ),
                        // const Divider(
                        //   height: 0,
                        // ),
                        Visibility(
                          visible: Platform.isAndroid,
                          child: ListTile(
                            onTap: () {
                              // Navigate to Expired Courses
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => BlocProvider(
                              //       create: (context) =>
                              //           DashboardCoursesCubit(),
                              //       child: const ExpiredCourses(),
                              //     ),
                              //   ),
                              // );
                            },
                            title: const Text(
                              'Expired Courses',
                            ),
                            leading: Icon(
                              Icons.timer_off,
                              color: secondaryColor,
                            ), // Customize the icon
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: secondaryColor,
                            ),
                          ),
                        ),
                        // const Divider(
                        //   height: 0,
                        // ),
                        // ListTile(
                        //   onTap: () {
                        //     // Navigate to Share and Earn
                        //     Get.to(
                        //       () => const ResumeMaker(),
                        //     );
                        //   },
                        //   title: const Text('Resume Maker'),
                        //   leading: const Icon(
                        //     FontAwesomeIcons.fileWord,
                        //   ), // Customize the icon
                        // ),
                        const Divider(
                          height: 0,
                        ),
                        // Visibility(
                        //   visible: Platform.isAndroid,
                        //   child: ListTile(
                        //     onTap: () {
                        //       // Navigate to Share and Earn
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => const ShareEarn(),
                        //         ),
                        //       );
                        //     },
                        //     title: const Text('Share and Earn'),
                        //     leading: const Icon(Icons.share), // Customize the icon
                        //   ),
                        // ),
                        // const Divider(
                        //   height: 0,
                        // ),
                        ListTile(
                          onTap: () {
                            // Get.to(() => BlocProvider(
                            //       create: (context) => FeedbackCubit(),
                            //       child: const FeedBackPage(),
                            //     ));
                          },
                          title: const Text('Feedback'),
                          leading: Icon(
                            Icons.feed,
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
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                imageUrl: 'assets/others/no-image.png',
                                placeholder: (context, url) => Image.asset(
                                  'assets/others/no-image.png',
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/others/no-image.png',
                                  fit: BoxFit.cover,
                                ),
                                fit: BoxFit.cover,
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
