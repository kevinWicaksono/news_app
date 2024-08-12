import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:news_app/common/navigation.dart';
import 'package:news_app/common/text_theme.dart';
import 'package:news_app/data/ViewModels/vm_article.dart';
import 'package:news_app/pages/page_article_detail.dart';
import 'package:news_app/pages/page_article_web_view.dart';
import 'package:news_app/pages/page_home.dart';
import 'package:news_app/utils/background_service.dart';
import 'package:news_app/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
          textTheme: myTextTheme,
          colorScheme: const ColorScheme.light(
            primary: Colors.deepPurple,
          )),
      navigatorKey: navigatorKey,
      initialRoute: PageHome.routeName,
      routes: {
        PageHome.routeName: (context) => const PageHome(),
        PageArticleDetail.routeName: (context) => PageArticleDetail(
            article: ModalRoute.of(context)?.settings.arguments as VmArticle),
        PageArticleWebView.routeName: (context) => PageArticleWebView(
            url: ModalRoute.of(context)?.settings.arguments as String),
      },
    );
  }
}
