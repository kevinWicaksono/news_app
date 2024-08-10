import 'package:flutter/material.dart';
import 'package:news_app/common/styles.dart';
import 'package:news_app/data/ViewModels/vm_article.dart';
import 'package:news_app/pages/page_article_detail.dart';

class WidgetCardArticle extends StatelessWidget {
  final VmArticle article;

  const WidgetCardArticle({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        leading: Hero(
          tag: article.urlToImage!,
          child: Image.network(
            article.urlToImage!,
            width: 100,
          ),
        ),
        title: Text(
          article.title,
        ),
        subtitle: Text(article.author ?? ''),
        onTap: () => Navigator.pushNamed(
          context,
          PageArticleDetail.routeName,
          arguments: article,
        ),
      ),
    );
  }
}
