import 'package:flutter/material.dart';
import 'package:flutter_page_view_ssk/appdata_quotes.dart';
import 'package:flutter_page_view_ssk/display_quotes.dart';
import 'package:flutter_page_view_ssk/utils.dart';
import 'package:share_plus/share_plus.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _selectedIndex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Utils utils;
  bool isChecked = false;
  var _gotoIndex = 0;

  @override
  initState(){
    utils = Utils();
  }

  sendNotificationCheckBox() async{
    int notificationStatus = await utils.getNotificationFlagStatus();

    print (notificationStatus);

    if(notificationStatus == 0){
      isChecked = false;
      print('--------------> Uncheck check box');
    }else{
      isChecked = true;
      print('--------------> Check check box');
    }
  }

  Future<void> _showDailyMesssageSettingDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {

          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Send Daily Quotes: "),
                          Checkbox(
                              value: isChecked,
                              onChanged: (checked) {
                                setState(() {
                                  isChecked = checked!;
                                  print('----------------> Check Box Status: $checked');
                                });
                              })
                        ],
                      )
                    ],
                  )),
              title: Text('Daily Quotes Settings'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    print('---------->cancel invoked');
                    //cancel alert dialog
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    print('---------->Set daily message');
                    if (_formKey.currentState!.validate()) {
                      print('----------------> Check Box Status: $isChecked');

                      if(isChecked == true){
                        // flag true - 1, default quotes index - 0
                        utils.setNotificationSettings(1, 0);
                        // set daily notification
                        utils.scheduleNotification();
                      }else{
                        // cancel notification
                        // clear shared preference data
                        utils.cancelNotification();
                        utils.clearNotificationSettings();
                      }

                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('OK'),
                )
              ],
            );
          });
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text('James William'),
          backgroundColor: Colors.green.shade900,
          actions: [
            PopupMenuButton<int>(
                itemBuilder: (context) => [
                      PopupMenuItem(value: 1, child: Text("Share")),
                      PopupMenuItem(value: 2, child: Text("Daildy Quotes")),
                    ],
                elevation: 2,
                onSelected: (value) {
                  if (value == 1) {
                    _shareInfo();
                  } else if(value == 2){
                    sendNotificationCheckBox();
                    _showDailyMesssageSettingDialog(context);
                    ;
                  }
                }),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 50.0),
              height: 200.0,
              child: PageView.builder(
                //selection
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                //page movement
                controller: PageController(viewportFraction: 0.7),
                //total length
                itemCount: appDataQuotes.length,
                //Display quotes
                itemBuilder: (context, index) {
                  var quotes = appDataQuotes[index];
                  var scale = _selectedIndex == index ? 1.0 : 0.8;

                  print(quotes);
                  print(_selectedIndex);

                  return TweenAnimationBuilder(
                      tween: Tween(begin: scale, end: scale),
                      duration: Duration(milliseconds: 350),
                      child: DisplayQuotes(
                        appData: quotes,
                      ),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: child,
                        );
                      });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: new Text(
                    (_selectedIndex + 1).toString() +
                        '/' +
                        appDataQuotes.length.toString(),
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }

  _shareInfo() {
    print('----------->Share');

    print(appDataQuotes[_gotoIndex].quotes);
    Share.share(appDataQuotes[_gotoIndex].quotes);
  }
}
