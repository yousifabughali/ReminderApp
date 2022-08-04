import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_second_project/providers/db_reminder_provider.dart';
import 'package:reminder_second_project/views/widgets/reminder_item.dart';

class ItemListScreen extends StatefulWidget {
  String nameOfTheList;
  int listId;
   ItemListScreen({required this.nameOfTheList,required this.listId,Key? key}) : super(key: key);

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 90,
        centerTitle: true,
        leading: TextButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),
          label:  Text(
            'Lists'.tr(),
            style:  const TextStyle(fontSize: 18),
          ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(
        //       Icons.more_horiz_rounded,
        //       color: Colors.blue,
        //       size: 25,
        //     ),
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                widget.nameOfTheList,
                style:  const TextStyle(fontSize: 22, color: Colors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(height: 10,),

              ListView.builder(
                shrinkWrap: true,
                itemCount: Provider.of<ReminderProvider>(context,listen: false).reminders.where((e) => e.listId == widget.listId).length,
                itemBuilder: (context, index) {
                  return ReminderItem(
                    id: Provider.of<ReminderProvider>(context).reminders[index].id,
                    title: Provider.of<ReminderProvider>(context).reminders[index].title,
                    content: Provider.of<ReminderProvider>(context).reminders[index].content,
                    day: Provider.of<ReminderProvider>(context).reminders[index].day,
                    listId: Provider.of<ReminderProvider>(context).reminders[index].listId,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
