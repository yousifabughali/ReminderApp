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
      backgroundColor: Colors.black87,
      appBar: AppBar(
        leadingWidth: 90,
        backgroundColor: Colors.black87,
        title:const Text('All'),
        centerTitle: true,
        leading: TextButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          label: const Text(
            'Lists',
            style:  TextStyle(fontSize: 18),
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
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                     'All',
                     style:  TextStyle(fontSize: 22, color: Colors.grey),
                   ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text('0 Completed - ',style:  TextStyle(color: Colors.grey),),
                  TextButton(
                    onPressed: () {
                    },
                    child: const Text(
                      'Clear',
                      style: TextStyle(fontSize: 18,color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 1,color: Colors.grey,),
              const SizedBox(height: 10,),

              const Text(
                'ListName',
                style:  TextStyle(fontSize: 19, color: Colors.white),
              ),
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
              OutlinedButton.icon(onPressed: (){}, icon: const Icon(Icons.add_circle,color: Colors.grey,), label: const Text('')),
            ],
          ),
        ),
      ),
    );
  }
}
