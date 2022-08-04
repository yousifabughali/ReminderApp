import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_second_project/providers/db_reminder_provider.dart';
import 'package:reminder_second_project/views/widgets/reminder_item.dart';


class ScheduledRemindersScreen extends StatefulWidget {
  const ScheduledRemindersScreen({Key? key}) : super(key: key);

  @override
  State<ScheduledRemindersScreen> createState() => _ScheduledRemindersScreenState();
}

class _ScheduledRemindersScreenState extends State<ScheduledRemindersScreen> {
  @override
  Widget build(BuildContext context) {
    List scheduled=Provider.of<ReminderProvider>(context,listen: false).reminders.where((element) => element.day!=null).toList();

    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        leadingWidth: 90,
        leading: TextButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),
          label:  Text(
            'Lists'.tr(),
            style: const TextStyle(fontSize: 18),
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                'Scheduled'.tr(),
                style: TextStyle(fontSize: 22, color: Colors.blue),
              ),

              const SizedBox(height: 15,),
              ListView.builder(
                shrinkWrap: true,
                itemCount: scheduled.length,
                itemBuilder: (context, index) {
                  return ReminderItem(
                    id: scheduled[index].id,
                    title: scheduled[index].title,
                    content:scheduled[index].content,
                    day: scheduled[index].day,
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
