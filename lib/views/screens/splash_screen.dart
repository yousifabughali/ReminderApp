import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_second_project/providers/db_list_provider.dart';
import 'package:reminder_second_project/providers/db_reminder_provider.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ReminderProvider>(context,listen: false).read();
    Provider.of<ListProvider>(context,listen: false).read();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/HomeScreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/2.5,
                  height: MediaQuery.of(context).size.height/5.5,
                  child: Image.asset('assets/icons/logo.png',fit: BoxFit.fill,),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Reminder.tr()',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    color: Colors.grey.shade800,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}