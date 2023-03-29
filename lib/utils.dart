import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_page_view_ssk/appdata_quotes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings = AndroidInitializationSettings(
      'images');

  void initialiseNotifications() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void scheduleNotification() async {
    print('-------------->scheduleNotification');

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    // Get index
    int index = await getNotificationIndex();

    if (index < appDataQuotes.length) {
      print('------------- within array');
    } else {
      print('------------- end of array');
      index = 0;
    }

    var title = 'James Willam Quotes';
    // Get message
    String body = appDataQuotes[index].quotes;

    print(index);
    print(body);

    _flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      title,
      body,
      RepeatInterval.everyMinute,
      notificationDetails,
    );

    // Update Index
    setNotificationIndex(index++);
  }

  void cancelNotification() async {
    _flutterLocalNotificationsPlugin.cancel(0);
  }

  setNotificationSettings(int flag, int index) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('daily_message_flag', flag);
    prefs.setInt('daily_message_index', index);
  }

  Future<int> getNotificationFlagStatus() async {
    int _dailyMessageFlag = 0;
    final prefs = await SharedPreferences.getInstance();
    _dailyMessageFlag = (prefs.getInt('daily_message_flag') ?? 0);
    return _dailyMessageFlag;
  }

  Future<int> getNotificationIndex() async {
    var _dailyMessageIndex = 0;
    final prefs = await SharedPreferences.getInstance();
    _dailyMessageIndex = (prefs.getInt('daily_message_index') ?? 0);
    return _dailyMessageIndex;
  }

  setNotificationIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('daily_message_index', index);
  }

  clearNotificationSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('daily_message_flag', 0);
    prefs.setInt('daily_message_index', 0);
  }

}
