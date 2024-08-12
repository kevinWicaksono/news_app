import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/styles.dart';
import 'package:news_app/data/api/api_services.dart';
import 'package:news_app/pages/page_article_detail.dart';
import 'package:news_app/pages/page_article_list.dart';
import 'package:news_app/pages/page_settings.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/provider/scheduling_provider.dart';
import 'package:news_app/utils/notification_helper.dart';
import 'package:news_app/widgets/widget_platform.dart';
import 'package:provider/provider.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  static const routeName = '/home_page';

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  int _bottomNavIndex = 0;

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.news : Icons.public),
      label: "Headline",
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
      label: "Setting",
    ),
  ];

  final List<Widget> _listWidget = [
    ChangeNotifierProvider<NewsProvider>(
      create: (_) => NewsProvider(apiService: ApiService()),
      child: const PageArticleList(),
    ),
    ChangeNotifierProvider<SchedulingProvider>(
      create: (_) => SchedulingProvider(),
      child: const PageSettings(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(PageArticleDetail.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: secondaryColor,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: (selected) {
          setState(() {
            _bottomNavIndex = selected;
          });
        },
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: secondaryColor,
        items: _bottomNavBarItems,
      ),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WidgetPlatform(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
