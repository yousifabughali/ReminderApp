import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_second_project/providers/db_reminder_provider.dart';
import 'package:reminder_second_project/views/widgets/reminder_item.dart';


class TodayReminders extends StatefulWidget {
  const TodayReminders({Key? key}) : super(key: key);

  @override
  State<TodayReminders> createState() => _TodayRemindersState();
}

class _TodayRemindersState extends State<TodayReminders> {

  @override
  Widget build(BuildContext context) {
    List today=Provider.of<ReminderProvider>(context).reminders.where((element) => element.day?.day==DateTime.now().day).toList();

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        leadingWidth: 90,
        backgroundColor: Colors.black87,
        leading: TextButton.icon(
          onPressed: () {
            Navigator.pop(context);

          },
          icon: const Icon(Icons.arrow_back_ios),
          label: const Text(
            'Lists',
            style: TextStyle(fontSize: 18),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
            },
            icon: const Icon(
              Icons.more_horiz_rounded,
              color: Colors.blue,
              size: 25,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Today',
                      style: TextStyle(fontSize: 22, color: Colors.blue),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                   // ReminderItem(),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: today.length,
                      itemBuilder: (context, index) {
                        return ReminderItem(
                          id: today[index].id,
                          title: today[index].title,
                          content:today[index].content,
                          day: today[index].day,
                        );
                      },
                    ),

                    OutlinedButton.icon(onPressed: (){}, icon: const Icon(Icons.add_circle,color: Colors.grey,), label: const Text('')),

                  ],
                ),
              ),
            ),
            TextButton.icon(onPressed: (){}, label: const Text('New Reminder'),icon: const Icon(Icons.add_circle),)
          ],
        ),
      ),
    );
  }
}
