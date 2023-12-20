import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initNotification();
    setListener();
  }

  void initNotification() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelGroupKey: "basic_channel_group",
        channelKey: "basic_channel",
        channelName: "Basic Notification",
        channelDescription: "Basic notifications channel",
      ),
      NotificationChannel(
        channelGroupKey: "basic_channel_group",
        channelKey: "basic_channel_1",
        channelName: "Basic Notification",
        channelDescription: "Skibidi dop",
      )
    ], channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: "basic_channel_group",
        channelGroupName: "Basic Group",
      )
    ]);
    bool isAllowedToSendNotification =
        await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowedToSendNotification) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  void setListener() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod:
            AwesomeNotificationsController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            AwesomeNotificationsController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            AwesomeNotificationsController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            AwesomeNotificationsController.onDismissActionReceivedMethod);
  }
}

class AwesomeNotificationsController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {}

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {}

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {}

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {}
}
