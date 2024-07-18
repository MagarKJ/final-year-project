import 'dart:developer';

import 'package:final_project/view/screens/home/note_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../controller/bloc/notification/notification_bloc.dart';

class Notifications extends StatefulWidget {
  const Notifications({
    super.key,
  });

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    // context.read<NotificationBloc>().add(NotificationLoadedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text('Notifications'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.alarm),
            onPressed: () {
              Get.to(() => PillReminder());
            },
          ),
        ],
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationInitial) {
            log(state.toString());
            BlocProvider.of<NotificationBloc>(context)
                .add(NotificationLoadedEvent());
          } else if (state is NotificationLoadingstate) {
            log(state.toString());
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is NotificationSuccessstate) {
            log(state.toString());
            return ListView.builder(
              itemCount: state.messgae.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    state.messgae[index]['notification']['title'],
                  ),
                  subtitle: Text(
                    state.messgae[index]['notification']['body'],
                  ),
                );
              },
            );
          }
          if (state is NotificationFailurestate) {
            log(state.toString());
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
        //  StreamBuilder<QuerySnapshot>(
        //   stream: FirebaseFirestore.instance.collection('messages').snapshots(),
        //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //     if (snapshot.hasError) {
        //       return Text('Something went wrong');
        //     }

        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Text("Loading");
        //     }

        //     return ListView(
        //       children: snapshot.data!.docs.map((DocumentSnapshot document) {
        //         Map<String, dynamic> data =
        //             document.data() as Map<String, dynamic>;
        //         return ListTile(
        //           title: Text(
        //             data['notification']['title'],
        //           ),
        //           subtitle: Text(
        //             data['notification']['body'],
        //           ),
        //         );
        //       }).toList(),
        //     );
        //   },
        // ),
      ),
    );
  }
}
