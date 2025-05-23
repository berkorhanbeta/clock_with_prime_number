import 'dart:async';
import 'package:deepcare_clock/utils/app_constant.dart';
import 'package:deepcare_clock/utils/page_navigation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeController extends ChangeNotifier {

  DateTime _cTime = DateTime.now();
  bool _second = true;
  Dio dio = new Dio();
  StreamSubscription? _streamSubscription;

  DateTime get currentTime => _cTime;
  bool get second => _second;

  HomeController(){

    // Starting our clock.
    Stream clock = Stream.periodic(
      Duration(seconds: 1), (_) {
        // Every 1 second, fetch current time.
        _cTime = DateTime.now();
        // True or False our Blinker.
        _second = !_second;
        // Update UI for listeners.
        notifyListeners();
      }
    );

    // Listen our stream till application closed.
    clock.listen((data) => ());
    // Fetch Random number.
    startAPI();
  }

  void startAPI() {
    Stream api = Stream.periodic(
        Duration(seconds: 3), (data) async {
          // Fetch data from API.
          final response = await dio.get(AppConstant.Api_Url);
          // API return [X] as list.
          // So we are fetching the number inside of the.
          int number = (response.data as List).first;
          // Is it prime?
          if(calculatePrime(number)){
            // If yes, Cancel our API calls
            _streamSubscription!.cancel();
            // Send our prime number to congrats page.
            Get.toNamed(PageNavigation.congrat, arguments: number);
          }}
    );

    // Subscribe to API call stream.
    _streamSubscription = api.listen((data) {});
  }


  // Simple calculation.
  // Ref. Info;
  // https://stackoverflow.com/questions/50930926/how-to-check-if-a-number-is-prime-in-a-more-efficient-manner
  bool calculatePrime(int num) {

    if(num <= 1) {
      return false;
    }

    if(num <= 3) {
      return true;
    }

    // If its dividable with 2 and 3, not a prime.
    if(num % 2 == 0 || num % 3 == 0) {
      return false;
    }


    // For 29;
    // 5 * 5 = 25 < 29 ;
    // 29 % 5 = 4, 29 % 7 = 1 , FALSE
    // 11 * 11 = 121 < 29 , FALSE
    //  +6i = Finds potential prime numbers.
    for(int i = 5; i * i <= num; i += 6) {
      if(num % i == 0 || num % (i+2) == 0) {
        return false;
      }
    }

    return true;
  }

}