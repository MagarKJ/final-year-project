import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/controller/bloc/profile/profile_bloc.dart';
import 'package:final_project/utils/constants.dart';
import 'package:final_project/view/authentication/login.dart';
import 'package:final_project/view/screens/profile/profile_editor.dart';
import 'package:final_project/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? email = 'Not Set';
  String? name = 'Not Set';
  String? phone = 'Not Set';
  String? profile = 'Not Set';
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadUserData();
    _loadUserDataFromGoogle();
  }

//Firebase bata user ko data load garne
  Future<void> _loadUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      if (userData.exists) {
        setState(() {
          email = userData['email'];
          name = userData['name'];
          phone = userData['phoneno'];
        });
      } else {
        email = 'Not Set';
        name = 'Not Set';
        phone = 'Not Set';
      }
    }
  }

  //
  Future<void> _loadUserDataFromGoogle() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      if (currentUser.displayName != null) {
        setState(() {
          email = currentUser.email;
          name = currentUser.displayName;
          // Google Sign-In doesn't provide phone number
          // You might want to ask the user to enter it manually
          phone = 'Not Set';
          profile = currentUser.photoURL;
        });
      } else {
        email = 'Not Set';
        name = 'Not Set';
        phone = 'Not Set';
        profile = 'Not Set';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) async {
        if (state is ProfileLogoutState) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          //shared preferences ko value false gardeko kina ki pheri splash bata onboarding ma janee
          //siddhai login rakhdim lagethyo pheri onboarding kati bela dekhaune tani banyo banyoo
          //value false vaye login ma janxa true vaye home so on boarding dekhauna paudenaa
          prefs.setBool('Login', false);

          Get.offAll(() => const LoginScreen());
        }
      },
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: myBrownColor,
              ),
            ),
            title: Text(
              'Profile',
              style: GoogleFonts.poppins(
                color: myBrownColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              //color: Colors.amber,
              width: Get.width * 0.9,
              height: Get.height * 0.7,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: Get.height * 0.14,
                      ),
                      Stack(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: profile != null &&
                                        Uri.parse(profile!).isAbsolute
                                    ? NetworkImage(profile!)
                                    : const AssetImage(userProfile)
                                        as ImageProvider<Object>?,
                                radius: Get.width * 0.1,
                              ),
                              SizedBox(
                                width: Get.width * 0.04,
                                height: Get.height * 0.12,
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: Get.height * 0.05,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: myBrownColor,
                                  border: Border.all(
                                      width: 2, color: Colors.white)),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.edit_outlined,
                                  color: Colors.white,
                                  size: Get.width * 0.06,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: Get.width * 0.5,
                        //color: Colors.red,
                        height: Get.height * 0.1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$name',
                              style: GoogleFonts.poppins(
                                  fontSize: 20, color: myBrownColor),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.mail_outline,
                                  color: myDarkGrey,
                                ),
                                SizedBox(
                                  width: Get.width * 0.02,
                                ),
                                Text(
                                  '$email',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14, color: myDarkGrey),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.call_outlined,
                                  color: myDarkGrey,
                                ),
                                SizedBox(
                                  width: Get.width * 0.02,
                                ),
                                Text(
                                  '$phone',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14, color: myDarkGrey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  SizedBox(
                    // color: Colors.red,
                    height: Get.height * 0.4,
                    width: Get.width * 0.9,
                    child: Column(
                      children: [
                        _buildRowContent(
                            context,
                            'Edit Your Details',
                            Icons.favorite_outline,
                            Icons.arrow_forward_ios, () {
                          Get.to(() => const EditYourProfile());
                        }),
                        _buildRowContent(
                            context,
                            'Food History',
                            Icons.history_outlined,
                            Icons.arrow_forward_ios,
                            () {}),
                        _buildRowContent(
                            context,
                            'Manage Your Goals',
                            Icons.manage_search_outlined,
                            Icons.arrow_forward_ios,
                            () {}),
                        _buildRowContent(
                            context,
                            'Change Password',
                            Icons.vpn_key_outlined,
                            Icons.arrow_forward_ios,
                            () {}),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomSheet: CustomButton(
            buttonText: 'LOG OUT',
            onPressed: () {
              _logoutDialogBox();
            },
            width: Get.width * 0.4,
            height: Get.height * 0.06,
            fontSize: 12,
            backGroundColor: myLightRed,
            icon: Icons.logout_outlined,
          ),
        );
      },
    );
  }

  Widget _buildRowContent(BuildContext context, String title, IconData icon1,
      IconData icon2, void Function()? onPressed) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: ListTile(
            title: Row(
              children: [
                Icon(
                  icon1,
                  color: myBrownColor,
                ),
                SizedBox(
                  width: Get.width * 0.03,
                ),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            trailing: Icon(
              icon2,
              color: myDarkGrey,
            ),
          ),
        ),
      ],
    );
  }

  void _logoutDialogBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<ProfileBloc>().add(LogoutButtonPressedEvent());
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
