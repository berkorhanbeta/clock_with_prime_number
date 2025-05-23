import 'package:deepcare_clock/modules/shared_pref.dart';
import 'package:flutter/material.dart';

class CongratController extends ChangeNotifier {

  String? duration;
  Future<void> findTimeDiff() async {
    // Getting our time passed since last prime number.
    // Convertion to string for elimination of milisecond.
    duration = (await SharedPref().getDate()).toString();

    // Remove the milisecond section.
    duration = duration!.split('.').first.padLeft(8, '0');

    // Short version.
    // Getting last date from SharedPref
    // Also we are deleting milisecond.
    //duration = (await SharedPref().getDate()).toString().split('.').first.padLeft(8, '0');

    // Updating UI.
    notifyListeners();
  }
}