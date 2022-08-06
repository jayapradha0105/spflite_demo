import 'package:thiran_demo/Services/database.dart';
import 'package:thiran_demo/View/dashboard.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
    final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    
    Future.delayed(const Duration(milliseconds: 2000), () async{
      await dbHelper.delete();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Github Repos",
            style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "Thiran Tech",
            style: TextStyle(
                color: Colors.deepPurple, fontSize: 19, height: 2),
          )
        ],
      ),
    ));
  }
}
