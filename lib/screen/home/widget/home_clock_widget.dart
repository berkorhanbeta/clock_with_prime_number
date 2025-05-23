import 'package:deepcare_clock/modules/home_controller.dart';
import 'package:deepcare_clock/utils/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeClockWidget extends StatelessWidget {

  bool _blink = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // We don't want to refresh all the UI.
    // Right now, we are only refreshing HomeClockWidget.
    // This method used for Optimization.
    return Selector<HomeController, DateTime>(
      selector: (_, controller) {
        final time = controller.currentTime; // Fetch Current Time
        _blink = controller.second; // Fetch Second for Blink
        return time;
      },
      builder: (_, time, __) {

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${time.hour.toString().padLeft(2, '0')} ${_blink ? ':' : ' '} ${time.minute.toString().padLeft(2, '0')} ',
                  style: TextStyle(
                    fontSize: 60.sp,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            AppConstant.useItnl ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${DateFormat('EE. d. MMM.').format(time)} ',
                  style: TextStyle(
                      fontSize: 30.sp
                  ),
                ),
                Text('WH ${calculateWeek(time)}',
                  style: TextStyle(
                      fontSize: 15.sp
                  ),
                ),
              ],
            ) : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${day[time.weekday-1]}, ${time.day} ${month[time.month-1]} ',
                  style: TextStyle(
                      fontSize: 30.sp
                  ),
                ),
                Text('WH ${calculateWeek(time)}',
                  style: TextStyle(
                    fontSize: 15.sp,
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }


  int calculateWeek(DateTime time){
    // Finding first day of the year.
    final firstDay = DateTime(time.year, 1, 1);

    // Find how many days between today and first day of the year.
    final days = time.difference(firstDay).inDays;

    // Find the how many weeks
    return ((days + firstDay.weekday) / 7).ceil();
  }

  List<String> day = [
    'Mon.', 'Tue.', 'Wed.',
    'Thu.', 'Fri.', 'Sat.',
    'Sun.'
  ];

  List<String> month = [
    'Jan.', 'Feb.', 'Mar.', 'Apr.',
    'May.', 'Jun.', 'Jul.', 'Aug.',
    'Sep.', 'Oct.', 'Nov.', 'Dec.'
  ];

}