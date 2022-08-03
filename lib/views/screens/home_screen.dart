import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_second_project/providers/change_dark.dart';
import 'package:reminder_second_project/providers/db_list_provider.dart';
import 'package:reminder_second_project/providers/db_reminder_provider.dart';
import 'package:reminder_second_project/views/widgets/Item_of_list.dart';
import 'package:reminder_second_project/views/widgets/content_of_new_list.dart';
import 'package:reminder_second_project/views/widgets/content_of_new_reminder.dart';
import 'package:reminder_second_project/views/widgets/hs_custom_card_view.dart';
import 'package:easy_localization/easy_localization.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: Switch(
          activeColor: Colors.blue,
          value: Provider.of<ChangeDark>(context).isDark,
          onChanged: (value) {
            Provider.of<ChangeDark>(context,listen: false).changeTheme(value);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Edit',
              style: TextStyle(
                fontSize: 15,
                color: Colors.blue,
              ),
            ),
          ),
          IconButton(onPressed: (){
            if(context.locale.toString()=='ar'){
              context.setLocale(Locale('en',));
            }else{
              context.setLocale(Locale('ar'));
            }
          }, icon: Icon(Icons.language),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomHomeScreenCard(
                                navRoute: '/AllReminders',
                                icon: Icons.all_inbox,
                                backgroundColor: const Color(0xff5c5c5f),
                                count: Provider
                                    .of<ReminderProvider>(context)
                                    .reminders
                                    .length,
                                nameOnTheCard: 'All'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CustomHomeScreenCard(
                                navRoute: '/ScheduledReminders',
                                icon: Icons.edit_calendar,
                                backgroundColor: Colors.red,
                                count: Provider
                                    .of<ReminderProvider>(context)
                                    .reminders
                                    .where((element) => element.day != null)
                                    .length,
                                nameOnTheCard: 'Scheduled'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomHomeScreenCard(
                                navRoute: '/TodayReminders',
                                icon: Icons.calendar_today_rounded,
                                backgroundColor: Colors.blue,
                                count: Provider
                                    .of<ReminderProvider>(context)
                                    .reminders
                                    .where((element) =>
                                element.day?.day == DateTime
                                    .now()
                                    .day)
                                    .length,
                                nameOnTheCard: 'Today'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        ' My Lists',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(14),
                          //TODO: COMPLETE list view builder
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return MyListWidget(
                              id:Provider.of<ListProvider>(context)
                                  .list[index].id,
                              title:Provider.of<ListProvider>(context)
                                  .list[index].title,
                              color:Provider
                                  .of<ListProvider>(context)
                                  .list[index].list_color,
                              );

                          },
                          itemCount: Provider
                              .of<ListProvider>(context)
                              .list
                              .length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Buttom Navigation Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    _showBottomSheet(context, NewReminderFirstScreen());
                  },
                  icon: const Icon(
                    Icons.add_circle,
                    color: Colors.blue,
                    size: 18,
                  ),
                  label: const Text(
                    'New Reminder',
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      _showBottomSheet(context, AddNewList());
                    },
                    child: const Text('New List')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _showBottomSheet(BuildContext context, Widget widget) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black87.withOpacity(0.95),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.91,
          child: widget,
        );
      },
    );
  }
}
