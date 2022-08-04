import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_second_project/model/list_model.dart';
import 'package:reminder_second_project/providers/db_list_provider.dart';
import 'package:reminder_second_project/providers/db_reminder_provider.dart';
import 'package:reminder_second_project/views/screens/edit_reminder_details.dart';

class ReminderItem extends StatefulWidget {
  late int id;
  late String title;
  late String content;
  late DateTime? day;
   late int? listId;
   late ListModel? listModel;


  ReminderItem({
    required this.id,
    required this.title,
    required this.content,
    this.day,
    this.listId,
    Key? key,
  }) : super(key: key);

  @override
  State<ReminderItem> createState() => _ReminderItemState();
}

class _ReminderItemState extends State<ReminderItem> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

        Navigator.push(context, MaterialPageRoute(builder: (context){
          return EditReminderDetails(id: widget.id,title: widget.title,content: widget.content,day: widget.day,listId: widget.listId,
          );
        }));
      },
      child: Dismissible(
        key: Key(widget.id.toString()),
        background: const SizedBox(),
        confirmDismiss: (DismissDirection direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.black,
                title:  Text(
                  "Delete Confirmation".tr(),
                  style: TextStyle(color: Colors.white),
                ),
                content:  Text(
                  "Are you sure you want to delete this item?".tr(),
                  style: TextStyle(color: Colors.white),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async {
                      await Provider.of<ReminderProvider>(context, listen: false)
                          .delete(id: widget.id);
                      Navigator.pop(context);
                    },
                    child:  Text(
                      "Delete".tr(),
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child:  Text(
                      "Cancel".tr(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          );
        },
        secondaryBackground: Container(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:  [
                Icon(Icons.delete, color: Colors.white),
                Text('Move to trash'.tr(), style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
          margin: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border(
              bottom: BorderSide(color: Colors.grey, width: 1),
            ),
          ),
          child: Row(
            children: [
              // Checkbox(
              //     value: false,
              //     onChanged: (_) {},
              //     side: BorderSide(color: Colors.white)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle( fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    ' ${widget.content}',
                    // style: const TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  SizedBox(
                    height: 18,
                  ),
                  Text(
                    widget.day != null ? widget.day.toString() : '',
                    // style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
