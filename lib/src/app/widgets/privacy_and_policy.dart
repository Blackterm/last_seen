import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PolicyAndPrivacyPage extends StatelessWidget {
  final String page;
  final String content;
  const PolicyAndPrivacyPage({
    Key? key,
    required this.page,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
              page == "privacy" ? "privacypolicy".tr() : "termsofuse".tr())),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(content),
        ),
      ),
    );
  }
}
