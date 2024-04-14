import 'package:final_project/controller/bloc/profile/bloc/profile_bloc.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/view/authentication/login.dart';
import 'package:final_project/widgets/custom_button.dart';
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
  bool s1 = false;
  String? email = 'Not Set';
  String? name = 'Not Set';
  String? phone = 'Not Set';
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      email = prefs.getString('email');
      name = prefs.getString('name');
      phone = prefs.getString('phone');
    });
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
                                backgroundImage:
                                    const AssetImage('assets/logo/apple.png'),
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
                            'MyFavourite',
                            Icons.favorite_outline,
                            Icons.arrow_forward_ios,
                            () {}),
                        _buildRowContent(
                            context,
                            'Purchase History',
                            Icons.history_outlined,
                            Icons.arrow_forward_ios,
                            () {}),
                        _buildRowContent(
                            context,
                            'Manage Shiping Address',
                            Icons.location_on_outlined,
                            Icons.arrow_forward_ios,
                            () {}),
                        _buildRowContent(
                            context,
                            'Change Password',
                            Icons.vpn_key_outlined,
                            Icons.arrow_forward_ios,
                            () {}),
                        SizedBox(
                          //   color: Colors.red,
                          height: Get.height * 0.06,
                          width: Get.width * 0.82,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.feed_outlined,
                                    color: myBrownColor,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.03,
                                  ),
                                  Text(
                                    'Newsletter Subscription',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                              Switch(
                                value: s1,
                                activeColor: Colors.white,
                                activeTrackColor: myBrownColor,
                                inactiveThumbColor: myBrownColor,
                                inactiveTrackColor: Colors.white,
                                onChanged: (bool value) {
                                  setState(() {
                                    s1 = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
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
