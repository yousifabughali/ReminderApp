import 'package:flutter/material.dart';

class ItemFromListsScreen extends StatefulWidget {
  const ItemFromListsScreen({Key? key}) : super(key: key);

  @override
  State<ItemFromListsScreen> createState() => _ItemFromListsScreenState();
}

class _ItemFromListsScreenState extends State<ItemFromListsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          leadingWidth: 80,
          backgroundColor: Colors.black87,
          leading: TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
            label: Text(
              'Lists',
            ),
          ),
          actions: [
            Icon(
              Icons.more_horiz_rounded,
              color: Colors.blue,
              size: 25,
            ),
            SizedBox(width: 10,),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ListName',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              // ReminderItem(),
              OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add_circle,
                    color: Colors.grey,
                  ),
                  label: Text('')),
            ],
          ),
        ));
  }
}
