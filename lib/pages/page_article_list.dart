import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data/api/api_services.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/widgets/widget_card_article.dart';
import 'package:news_app/widgets/widget_platform.dart';

class PageArticleList extends StatefulWidget {
  static const routeName = '/article_list';

  const PageArticleList({super.key});

  @override
  State<PageArticleList> createState() => _PageArticleListState();
}

class _PageArticleListState extends State<PageArticleList> {
  late Future<ArticlesResult> _article;

  @override
  void initState() {
    super.initState();

    _article = ApiService().topHeadlines();
  }

  Widget _buildList(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FilledButton(
            child: const Text('Refresh Data'),
            onPressed: () {
              setState(() {
                _article = ApiService().topHeadlines();
              });
            },
          ),
          FutureBuilder<ArticlesResult>(
            future: _article,
            builder: (context, AsyncSnapshot<ArticlesResult> snapshot) {
              var state = snapshot.connectionState;
              if (state != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.articles.length,
                    itemBuilder: (context, index) {
                      var article = snapshot.data?.articles[index];
                      return WidgetCardArticle(article: article!);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Material(
                      child: Text(snapshot.error.toString()),
                    ),
                  );
                } else {
                  return const Material(child: Text(''));
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('News App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
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
