import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {

  SharedPreferences? pref;
  Future<void> saveDate(DateTime time) async {
    print('asdas');
    pref = await SharedPreferences.getInstance();
    try {
      // If prime number founded, then we save into Shared Preferences.
      // With 'date' variable name.
      await pref!.setString('date', time.toString());
    } catch (e) {
      print(e);
    }
  }

  Future<Duration> getDate() async {
    pref = await SharedPreferences.getInstance();

    // Checking if 'date' was previously saved into Shared Preferences.
    if(pref!.getString('date') != null){

      // Get Last Date.
      DateTime lastDate = DateTime.parse(pref!.getString('date').toString());

      // Get Today's Date.
      DateTime todaysDate = DateTime.now();

      // Calculating how many days-hour-minute past since last Prime.
      final calcuDifference = todaysDate.difference(lastDate);

      // Save the new Date.
      await saveDate(todaysDate);

      return calcuDifference;

      // Short Version...
      //today = DateTime.now(); // Current Date
      //saveDate(today); // Saved to Shared Pref
      //return today.difference(DateTime.parse(pref!.getString('date').toString())); // Return Difference
    } else {
      // If prime has never been found previously.
      // Returning current time and date.
      saveDate(DateTime.now());
      return Duration(days: 0);
    }
  }
}