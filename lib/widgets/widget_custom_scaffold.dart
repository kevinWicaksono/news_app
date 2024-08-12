import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/navigation.dart';

class WidgetCustomScaffold extends StatelessWidget {
  final Widget body;

  const WidgetCustomScaffold({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            body,
            _customAppBar(context),
          ],
        ),
      ),
    );
  }

  Card _customAppBar(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(16.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: defaultTargetPlatform == TargetPlatform.iOS
                ? const Icon(CupertinoIcons.back)
                : const Icon(Icons.arrow_back),
            onPressed: () {
              Navigation.back();
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              'News App',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}
