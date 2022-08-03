import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_second_project/model/list_model.dart';
import 'package:reminder_second_project/model/reminder_model.dart';
import 'package:reminder_second_project/providers/db_list_provider.dart';
import 'package:reminder_second_project/providers/db_reminder_provider.dart';
import 'package:reminder_second_project/views/widgets/Item_of_list.dart';
import 'package:reminder_second_project/views/widgets/list_selector.dart';

class NewReminderFirstScreen extends StatefulWidget {
   NewReminderFirstScreen({
    Key? key,
  }) : super(key: key);
  DateTime? day;
   ListModel? listId;



  @override
  State<NewReminderFirstScreen> createState() => _NewReminderFirstScreenState();
}

class _NewReminderFirstScreenState extends State<NewReminderFirstScreen> {
  late TextEditingController _contentTextEditing, _titleTextEditing;
  // List? result;

  @override
  void initState() {
    _contentTextEditing = TextEditingController();
    _titleTextEditing = TextEditingController();
    // checkTheList();

    super.initState();
  }
  // checkTheList() async {
  //   if( Provider.of<ListProvider>(context).list.isNotEmpty){
  //   widget.listId = await Provider.of<ListProvider>(context).list.first;
  //   }
  // }

  @override
  void dispose() {
    _contentTextEditing.dispose();
    _titleTextEditing.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.listId = Provider.of<ListProvider>(context).list.first;
    return SafeArea(
      child: Padding(
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
                    child: const Text('Cancel'),
                  ),
                  //TODO: modifying the title of the content (Edit, New)
                  // Text(
                  //   'New Reminder',
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 18,
                  //   ),
                  // ),
                  TextButton(
                      onPressed: () async {
                        performSave();
                      },
                      child: const Text('Add')),
                ],
              ),
              const SizedBox(height: 10),
              // Name And Note
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 2),
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Time
              const Text(
                '  Schedule your reminder',
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
                      title: const Text(
                        'Date and time',
                        style: TextStyle(color: Colors.white),
                      ),
                      leading: const Icon(Icons.date_range),
                      children: [
                        SizedBox(
                          height: 200,
                          child: CupertinoDatePicker(
                            initialDateTime: DateTime.now(),
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
                height: 15,
              ),
              // choose List
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800.withOpacity(0.90),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Text(
                      'Tap to Select the List',
                      style: TextStyle(color: Colors.white),
                    ),
                    // Text(result == null
                    //     ? Provider.of<ListProvider>(context).list.first.title
                    //     : result![0]),
                    // Spacer(),
                    //TODO
                    Spacer(),


                    SizedBox(
                      width: 101,
                      child: DropdownButton<ListModel>(
                        hint: Text('Reminders'),
                        underline: SizedBox(),
                        value: widget.listId,
                        items: Provider.of<ListProvider>(context).list.map((ListModel value) {
                          return DropdownMenuItem<ListModel>(
                            value: value,
                            child: Text(value.title),
                          );
                        }).toList(),

                        onChanged: (v){
                          setState((){
                            widget.listId=v;
                          });

                        },

                      ),
                    ),
                  ],

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> performSave() async {
    if (CheckData()) {
      await save();
    }
  }

  bool CheckData() {
    if (_contentTextEditing.text.isNotEmpty &&
        _titleTextEditing.text.isNotEmpty) {
      return true;
    }
    showSnackBar(message: 'Enter required data', error: true);
    return false;
  }

  ReminderModel get reminder {
    ReminderModel newReminder = ReminderModel();
    newReminder.content = _contentTextEditing.text;
    newReminder.title = _titleTextEditing.text;
    newReminder.day = widget.day;
    newReminder.listId =widget.listId!.id;
    // newReminder.listIdModel=widget.listId;
    return newReminder;
  }

  Future<void> save() async {
    bool created = await Provider.of<ReminderProvider>(context, listen: false)
        .create(reminder: reminder);
    if (created) {
      clear();
      Navigator.pop(context);
    }
    String message = created ? 'Created Successfully' : 'Created failed';
    showSnackBar(message: message, error: !created);
  }

  void showSnackBar({required String message, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: error ? Colors.red : Colors.green,
    ));
  }

  void clear() {
    _contentTextEditing.text = '';
    _titleTextEditing.text = '';
  }


}
