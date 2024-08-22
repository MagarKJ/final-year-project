import 'dart:io';
import 'package:final_project/controller/apis/user_data_repository.dart';
import 'package:final_project/controller/bloc/profile/profile_bloc.dart';
import 'package:final_project/view/bottom_navigtion_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/constants.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  int selectedTab = 0;
  XFile? file;

  GetUserData user = GetUserData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          surfaceTintColor: whiteColor,
          centerTitle: false,
          title: const Text('Profile Image'),
          backgroundColor: whiteColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Get.offAll(() => MyBottomNavigationBar(
                    currentIndex: 4,
                  ));
            },
          )),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, top: 10, right: 10, bottom: 10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Change Profile Picture',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: myDarkGrey),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('No files Picked'),
                          ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(),
                              onPressed: () async {
                                final picker = ImagePicker();
                                final pickedFile = await picker.pickImage(
                                  source: ImageSource.gallery,
                                  imageQuality: 100,
                                );
                                setState(() {
                                  file = pickedFile;
                                });
                              },
                              icon: const Icon(Icons.upload_file),
                              label: const Text('Pick a file')),
                        ],
                      ),
                      if (file != null)
                        Image.file(
                          File(file!.path),
                          height: 200,
                          width: 200,
                        ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '(Recommended 100 X 100 px)',
                      style: TextStyle(
                          color: secondaryColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: Get.height * 0.06,
              width: Get.width * 0.92,
              child: MaterialButton(
                color: primaryColor,
                onPressed: () {
                  (file != '')
                      ? BlocProvider.of<ProfileBloc>(context).add(
                          UpdateUserPhoto(
                            image: file!,
                          ),
                        )
                      //     value['status'] == true
                      //         ? {
                      //             setState(() {
                      //               isLoading = false;
                      //             }),
                      //             showDialog(
                      //                 context: context,
                      //                 builder: (ctx) {
                      //                   value['imageFile'] != null
                      //                       ? {
                      //                           saveImage(value['imageFile']),
                      //                           image = value['imageFile']
                      //                         }
                      //                       : null;
                      //                   return AlertDialog(
                      //                     title: const Text('Image Updated'),
                      //                     content: const Text(
                      //                         'Image successfully updated'),
                      //                     actions: [
                      //                       ElevatedButton(
                      //                           onPressed: () {
                      //                             Get.offAll(() =>
                      //                                 MyBottomNavigationBar(
                      //                                   currentIndex: 4,
                      //                                 ));
                      //                           },
                      //                           child: const Text('Ok'))
                      //                     ],
                      //                   );
                      //                 })
                      //           }
                      //         : {
                      //             setState(() {
                      //               isLoading = false;
                      //             }),
                      //             Get.snackbar(
                      //               'Error',
                      //               'Something went wrong',
                      //               snackPosition: SnackPosition.BOTTOM,
                      //               backgroundColor: Colors.red,
                      //               colorText: Colors.white,
                      //               duration: const Duration(seconds: 2),
                      //             ),
                      //           };
                      //   })
                      : showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                content: const Text('Please pick an image'),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Ok'))
                                ],
                              ));
                },
                child: Text(
                  'Update Image',
                  style:
                      TextStyle(color: whiteColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
