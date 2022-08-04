import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_second_project/providers/db_reminder_provider.dart';
import 'package:reminder_second_project/views/widgets/reminder_item.dart';


class AllRemindersScreen extends StatefulWidget {
  const AllRemindersScreen({Key? key}) : super(key: key);

  @override
  State<AllRemindersScreen> createState() => _AllRemindersScreenState();
}

class _AllRemindersScreenState extends State<AllRemindersScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 90,
        title: Text('All'.tr()),
        centerTitle: true,
        leading: TextButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),
          label:  Text(
            'Lists'.tr(),
            style:  TextStyle(fontSize: 18),
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
                     'All'.tr(),
                     style:  TextStyle(fontSize: 22, color: Colors.grey),
                   ),
              const SizedBox(
                height: 10,
              ),
              // Row(
              //   children: [
              //     const Text('0 Completed - ',style:  TextStyle(color: Colors.grey),),
              //     TextButton(
              //       onPressed: () {
              //       },
              //       child: const Text(
              //         'Clear',
              //         style: TextStyle(fontSize: 18,color: Colors.blue),
              //       ),
              //     ),
              //   ],
              // ),
              // const Divider(thickness: 1,color: Colors.grey,),
              // const SizedBox(height: 10,),

              //  Text(
              //   'ListName'.tr(),
              //   style:  TextStyle(fontSize: 19, color: Colors.white),
              // ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: Provider.of<ReminderProvider>(context).reminders.length,
              itemBuilder: (context, index) {
                return ReminderItem(
                  id: Provider.of<ReminderProvider>(context).reminders[index].id,
                  title: Provider.of<ReminderProvider>(context).reminders[index].title,
                  content: Provider.of<ReminderProvider>(context).reminders[index].content,
                  day: Provider.of<ReminderProvider>(context).reminders[index].day,
                  listId:Provider.of<ReminderProvider>(context).reminders[index].listId,

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
