import 'dart:developer';
import 'dart:io';
import 'package:final_project/firebase_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constants.dart';

class PillReminder extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<PillReminder> {
  TextEditingController noteController = TextEditingController();
  List<String> notesList = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  void loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notesList = prefs.getStringList('notes') ?? [];
    });
    log('Loaded notes: $notesList');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        surfaceTintColor: whiteColor,
        titleSpacing: 0,
        title: Text(
          'Reminders',
          style: TextStyle(
            color: black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
        ),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          loadNotes();
        },
        child: ListView(
          children: [
            notesList.isEmpty
                ? const Center(
                    child: Text(
                      'No reminders available.',
                    ),
                  )
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: notesList.length,
                    itemBuilder: (context, index) {
                      bool isReminder = notesList[index].contains('(Reminder)');

                      return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        background: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: AlignmentDirectional.centerEnd,
                            color: Colors.red,
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        onDismissed: (direction) async {
                          // Delete note
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String deletedNote = notesList[index];
                          notesList.removeAt(index);
                          prefs.setStringList('notes', notesList);

                          // Cancel the scheduled notification associated with the deleted note
                          await FireBaseAPi()
                              .cancelScheduledReminder(deletedNote)
                              .then((value) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text(
                                        'Reminder Removed Successfully',
                                      ),
                                    ),
                                  ));
                          // var id = int.parse(deletedNote.split(' ')[0]);
                          // await Alarm.stop(id).then((value) =>
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       const SnackBar(
                          //         backgroundColor: Colors.green,
                          //         content: Text(
                          //           'Notes Removed Successfully',
                          //         ),
                          //       ),
                          //     ));

                          loadNotes();
                        },
                        child: GestureDetector(
                          onTap: () {
                            // view the note

                            Platform.isAndroid
                                ? showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        scrollable: true,
                                        title: const Text('Note'),
                                        content: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              notesList[index],
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                            const SizedBox(height: 16),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Close',
                                                    style: TextStyle(
                                                        color: secondaryColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                : showCupertinoDialog(
                                    context: context,
                                    builder: (context) {
                                      return CupertinoAlertDialog(
                                        title: const Text('Note'),
                                        content: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '  ${notesList[index].split(' ')[0]}',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.alarm,
                                                      size: 14,
                                                      color: isReminder
                                                          ? Colors.green
                                                          : Colors.red,
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      isReminder
                                                          ? 'Reminder'
                                                          : 'No Reminder Set',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: isReminder
                                                            ? Colors.green
                                                            : Colors.red,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    notesList[index]
                                                        .split('::')[1],
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Close',
                                                    style: TextStyle(
                                                        color: secondaryColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    spreadRadius: 5,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: double.maxFinite,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        notesList[index].split(' ')[1],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.alarm,
                                            color: isReminder
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            isReminder
                                                ? 'Reminder'
                                                : 'No Reminder Set',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: isReminder
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    notesList[index].split('::')[1],
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        onPressed: () async {
          Get.to(() => AddNotesPage(
                refreshNotes: loadNotes,
              ));
        },
        child: Icon(
          Icons.add,
          color: whiteColor,
        ),
      ),
    );
  }
}

class AddNotesPage extends StatefulWidget {
  Function? refreshNotes;
  AddNotesPage({this.refreshNotes});
  @override
  _AddNotesPageState createState() => _AddNotesPageState();
}

class _AddNotesPageState extends State<AddNotesPage> {
  TextEditingController noteController = TextEditingController();
  DateTime? _selectedDateTime;
  bool setReminder = false;

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  @override
  void dispose() {
    noteController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void showNotificationAndSchedule() async {
    log('Length: ${notesList.length}');
    String note = noteController.text;

    // Check if a reminder is set
    if (setReminder && _selectedDateTime != null) {
      log('Scheduling reminder for: $_selectedDateTime');
      // Schedule a notification at the selected time
      await FireBaseAPi().scheduleNotification(
        'Reminder',
        note,
        _selectedDateTime!,
      );
      // await Alarm.set(
      //   alarmSettings: AlarmSettings(
      //     loopAudio: false,
      //     id: notesList.length,
      //     dateTime: _selectedDateTime!,
      //     assetAudioPath: 'assets/alarm.mp3',
      //     vibrate: true,
      //     enableNotificationOnKill: true,
      //     notificationTitle: 'Reminder',
      //     notificationBody: note,
      //   ),
      // );
    }

    // Show a Flutter local notification immediately
  }

  List<String> notesList = [];
  void loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notesList = prefs.getStringList('notes') ?? [];
    });
    log('Loaded notes: $notesList');
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void saveNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String note = noteController.text;
    DateTime now =
        setReminder ? _selectedDateTime ?? DateTime.now() : DateTime.now();
    String timestamp =
        "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}";

    notesList.add(
        '${notesList.length} $timestamp::  $note${setReminder ? ' (Reminder)' : ''}');

    prefs.setStringList('notes', notesList);

    setState(() {
      noteController.clear();
      _selectedDateTime = null; // Clear the selectedDateTime after saving
    });
    loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          titleSpacing: 0,
          title: Text(
            'Add Reminder',
            style: TextStyle(
              color: black,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Set Reminder: '),
                    CupertinoSwitch(
                      value: setReminder,
                      onChanged: (value) {
                        setState(() {
                          setReminder = value;
                          if (!setReminder) {
                            _selectedDateTime = null;
                          }
                        });
                      },
                    ),
                  ],
                ),
                if (setReminder)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Select Date: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => _selectDate(context),
                          child: Text(
                              _selectedDateTime == null
                                  ? 'Select Date'
                                  : _selectedDateTime.toString().split('.')[0],
                              style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: noteController,
                    maxLines: 10,
                    maxLength: 500,
                    decoration: const InputDecoration(
                      labelText: 'Write Description',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (noteController.text.isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Please enter Description.',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                        return;
                      }
                      saveNote();
                      if (setReminder) {
                        print('true');
                        showNotificationAndSchedule();
                      }
                      widget.refreshNotes!();
                      Get.back();
                    },
                    child: Text(
                      'Save Reminder',
                      style: TextStyle(
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
