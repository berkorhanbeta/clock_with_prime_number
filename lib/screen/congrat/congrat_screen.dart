import 'package:deepcare_clock/modules/confetti_animation.dart';
import 'package:deepcare_clock/modules/congrat_controller.dart';
import 'package:deepcare_clock/modules/home_controller.dart';
import 'package:deepcare_clock/utils/images.dart';
import 'package:deepcare_clock/utils/page_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

class CongratScreen extends StatefulWidget{

  final primeNum;
  CongratScreen({Key? key}) : primeNum = Get.arguments as int?, super(key:key);

  @override
  State<CongratScreen> createState() => _CongratScreenState();
}

class _CongratScreenState extends State<CongratScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // If prime number is empty, then we are returning to home page.
    if(widget.primeNum == null) {
      Future.microtask(() => Get.offAllNamed(PageNavigation.home));
    }
    // Calling our function
    // for calculating time difference.
    Provider.of<CongratController>(context, listen: false).findTimeDiff();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('You Won!'),
        leading: BackButton(
          onPressed: () {
            // Restart our API Call.
            HomeController().startAPI();
            // Close this page.
            if(Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Get.offAllNamed(PageNavigation.home);
            }
          },
        ),
      ),
      body: Stack(
        children: [
          ConfettiWidget(),
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 15, left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Congratulations!',
                    style: TextStyle(
                        fontSize: 20.sp
                    )
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width / 3,
                  child: Image.asset(
                    Images.congrat,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('You obtained a prime number, it was: ',
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                    Text('${widget!.primeNum}',
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Time since last prime number ',
                      style: TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                    Text('${Provider.of<CongratController>(context, listen: true).duration}',
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Center(
                  child: FilledButton.icon(
                      onPressed: () {
                        // Restart our API Call.
                        HomeController().startAPI();
                        // Close this page.
                        if(Navigator.canPop(context)) {
                          Navigator.pop(context);
                        } else {
                          Get.offAllNamed(PageNavigation.home);
                        }
                      },
                      icon: Icon(Icons.close_outlined),
                      label: Text('Close'),
                      style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.all(20)
                      )
                  ),
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}