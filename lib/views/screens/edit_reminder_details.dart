import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_second_project/model/reminder_model.dart';
import 'package:reminder_second_project/providers/db_reminder_provider.dart';

class EditReminderDetails extends StatefulWidget {
  late int id;
  late String title;
  late String content;
  DateTime? day;
  int? listId;


  // late Color reminder_color = Colors.black;

  EditReminderDetails({
    Key? key,
    required this.id,
    required this.title,
    required this.content,
    this.day,
    this.listId,
  }) : super(key: key);

  @override
  State<EditReminderDetails> createState() => _EditReminderDetailsState();
}

class _EditReminderDetailsState extends State<EditReminderDetails> {
  late TextEditingController _contentTextEditing, _titleTextEditing;

  ReminderModel get reminder {
    ReminderModel newReminder = ReminderModel();
    newReminder.id = widget.id;
    newReminder.content = _contentTextEditing.text;
    newReminder.title = _titleTextEditing.text;
    newReminder.day = widget.day;
    newReminder.listId=widget.listId;
    return newReminder;
  }

  @override
  void initState() {
    super.initState();
    _contentTextEditing = TextEditingController();
    _titleTextEditing = TextEditingController();
    _titleTextEditing.text = widget.title;
    _contentTextEditing.text = widget.content;
  }


  @override
  void dispose() {
    _contentTextEditing.dispose();
    _titleTextEditing.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child:  Text('Cancel'.tr())),
                     Text(
                      'Details'.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          performEdit();
                        },
                        child:  Text('Edit'.tr())),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800.withOpacity(0.90),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          cursorColor: Colors.white,
                          maxLines: 1,
                          controller: _titleTextEditing,
                          decoration: const InputDecoration(
                            hintText: 'Title',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 2),
                          ),
                        ),
                        const Divider(
                          color: Colors.black87,
                        ),
                        TextFormField(
                          maxLines: 4,
                          cursorColor: Colors.white,
                          controller: _contentTextEditing,
                          decoration: const InputDecoration(
                            hintText: 'Note',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                 Text(
                  '  Edit the Date and Time if you want'.tr(),
                  style: TextStyle(color: Colors.blue),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800.withOpacity(0.90),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      ExpansionTile(
                        title:  Text(
                          'Edit the Date and time'.tr(),
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: const Icon(Icons.date_range),
                        children: [
                          SizedBox(
                            height: 200,
                            child: CupertinoDatePicker(
                              initialDateTime: widget.day,
                              onDateTimeChanged: (DateTime value) {
                                widget.day = value;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //TODO
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 10),
                //   height: 50,
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //     color: Colors.grey.shade800.withOpacity(0.90),
                //     borderRadius: BorderRadius.circular(14),
                //   ),
                //   child: Row(
                //     children: [
                //       Text(
                //         'Tap to Select the List',
                //         style: TextStyle(color: Colors.white),
                //       ),
                //       // Text(result == null
                //       //     ? Provider.of<ListProvider>(context).list.first.title
                //       //     : result![0]),
                //       // Spacer(),
                //       //TODO
                //       Spacer(),
                //
                //       SizedBox(
                //         width: 101,
                //         child: DropdownButton<ListModel>(
                //           hint: Text('Reminders'),
                //           underline: SizedBox(),
                //           value: widget.listIdModel,
                //           items: Provider.of<ListProvider>(context)
                //               .list
                //               .map((ListModel value) {
                //             return DropdownMenuItem<ListModel>(
                //               value: value,
                //               child: Text(value.title),
                //             );
                //           }).toList(),
                //           onChanged: (v) {
                //             setState(() {
                //               widget.listIdModel = v;
                //             });
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> performEdit() async {
    if (checkData()) {
      await editing();
    }
  }

  void showSnackBar({required String message, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: error ? Colors.red : Colors.green,
    ));
  }

  bool checkData() {
    if (_contentTextEditing.text.isNotEmpty &&
        _titleTextEditing.text.isNotEmpty) {
      return true;
    }
    showSnackBar(message: 'Enter required data'.tr(), error: true);
    return false;
  }

  Future<void> editing() async {
    bool edited = await Provider.of<ReminderProvider>(context, listen: false)
        .update(reminder: reminder);
    String message = edited ? 'Edited Successfully'.tr() : 'Edited failed'.tr();
    showSnackBar(message: message, error: !edited);
    setState(() {
      if (edited) {
        Navigator.pop(context);
      }
    });
  }
}
