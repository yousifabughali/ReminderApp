import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_second_project/providers/db_list_provider.dart';
import 'package:reminder_second_project/providers/db_reminder_provider.dart';
import 'package:reminder_second_project/views/widgets/Item_of_list.dart';

class ListSelector extends StatefulWidget {
  ListSelector({Key? key}) : super(key: key);



  @override
  State<ListSelector> createState() => _ListSelectorState();
}

class _ListSelectorState extends State<ListSelector> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.90),
          borderRadius: BorderRadius.circular(14),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: Provider.of<ListProvider>(context).list.length,
          itemBuilder: (context, index) {
            return MyListWidget(
              id: Provider.of<ListProvider>(context).list[index].id,
              title: Provider.of<ListProvider>(context).list[index].title,
              color: Provider.of<ListProvider>(context).list[index].list_color,
            );
          },
        ),
      ),
    );
  }
}
