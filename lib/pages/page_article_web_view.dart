import 'package:flutter/material.dart';
import 'package:news_app/widgets/widget_custom_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PageArticleWebView extends StatelessWidget {
  final String url;

  const PageArticleWebView({
    super.key,
    required this.url,
  });

  static const routeName = '/article_web_view';

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()..loadRequest(Uri.parse(url));
    return WidgetCustomScaffold(
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
