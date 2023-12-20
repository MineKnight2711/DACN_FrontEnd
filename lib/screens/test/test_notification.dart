import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/controller/notification_controller.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_button.dart';
import 'package:get/get.dart';

class TestNotificationScreen extends StatelessWidget {
  TestNotificationScreen({super.key});
  final notificationController = Get.find<NotificationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: RoundIconButton(
        title: "Test notify",
        onPressed: () {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: 1,
                channelKey: "basic_channel",
                title: "Hello world!",
                body: "Yay! I have local notifications working now!"),
          );
          AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: 2,
                channelKey: "basic_channel_1",
                title: "Merry Christmas!",
                body:
                    "You better watch out,you better not cry, you better not pout !"),
          );
        },
      )),
    );
  }
}
