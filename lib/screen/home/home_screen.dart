import 'package:deepcare_clock/screen/home/widget/home_clock_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clock'),
      ),
      body:  SingleChildScrollView(
        child: Center(
          child: HomeClockWidget(),
        ),
      )
    );
  }
}