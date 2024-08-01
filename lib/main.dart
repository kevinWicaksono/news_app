import 'package:flutter/material.dart';
import 'package:news_app/common/text_theme.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/pages/page_article_detail.dart';
import 'package:news_app/pages/page_article_list.dart';
import 'package:news_app/pages/page_article_web_view.dart';
import 'package:news_app/pages/page_home.dart';

void main() {
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
      initialRoute: PageHome.routeName,
      routes: {
        PageHome.routeName: (context) => const PageHome(),
        PageArticleDetail.routeName: (context) => PageArticleDetail(
            article: ModalRoute.of(context)?.settings.arguments as Article),
        PageArticleWebView.routeName: (context) => PageArticleWebView(
            url: ModalRoute.of(context)?.settings.arguments as String),
      },
    );
  }
}
