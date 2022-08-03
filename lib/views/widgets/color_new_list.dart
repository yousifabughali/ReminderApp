
import 'package:flutter/material.dart';


class ColorPicker extends StatelessWidget{

  Color color=Colors.blue;
  Function function;
   ColorPicker({
    Key? key,
     required this.color,
     required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        function(color);
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
