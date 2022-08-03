import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reminder_second_project/providers/db_list_provider.dart';
import 'package:reminder_second_project/providers/db_reminder_provider.dart';
import 'package:reminder_second_project/views/screens/item_list_screen.dart';
//TODO: REVIEW THE CODE

class MyListWidget extends StatefulWidget {
  late int id;
  late String title;
  late Color color;


   MyListWidget({Key? key,required this.id,required this.color,required this.title,}) : super(key: key);

  @override
  State<MyListWidget> createState() => _MyListWidgetState();
}

class _MyListWidgetState extends State<MyListWidget> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ItemListScreen(listId: widget.id,nameOfTheList: widget.title,);
        },),);
      },

      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              height:35,
              width: 35,
              margin: EdgeInsets.symmetric(vertical: 5,),
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(Icons.format_list_numbered_sharp),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: Text(widget.title,style: const TextStyle(color: Colors.white,fontSize: 17,),),
          ),
          const Spacer(),
          // if(widget.isSelected)
          // SizedBox(child: Icon(Icons.check),),
          // if(widget.isDelete)
            IconButton(
              onPressed: () {
                Provider.of<ListProvider>(context,listen: false).delete(id: widget.id);
                Provider.of<ReminderProvider>(context,listen:false).deletedByList(id: widget.id);


              }, icon: const Icon(Icons.delete,color: Colors.red,),),
        ],
      ),
    );
  }
}
