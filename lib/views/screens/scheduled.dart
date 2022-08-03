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
      backgroundColor: Colors.black87,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
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
            onPressed: () {},
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
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Scheduled',
                style: TextStyle(fontSize: 22, color: Colors.blue),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Today',
                style:  TextStyle(fontSize: 19, color: Colors.white),
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

              OutlinedButton.icon(onPressed: (){}, icon: const Icon(Icons.add_circle,color: Colors.grey,), label: const Text('')),
            ],
          ),
        ),
      ),
    );
  }
}
