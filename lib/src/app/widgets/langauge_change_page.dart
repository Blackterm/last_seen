import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wpfamilylastseen/src/domain/entities/last_seen_languages.dart';

class LanguageChangePage extends StatefulWidget {
  final String title;
  final List<LastSeenLanguages> lastSeenLanguages;
  const LanguageChangePage({
    Key? key,
    required this.title,
    required this.lastSeenLanguages,
  }) : super(key: key);

  @override
  State<LanguageChangePage> createState() => _LanguageChangePageState();
}

class _LanguageChangePageState extends State<LanguageChangePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: widget.lastSeenLanguages.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ListTile(
                  title: Text(widget.lastSeenLanguages[index].name!),
                  onTap: () {
                    setState(() {
                      context.setLocale(
                          Locale(widget.lastSeenLanguages[index].code!));
                    });
                  },
                  trailing: Localizations.localeOf(context).languageCode ==
                          widget.lastSeenLanguages[index].code!
                      ? Icon(Icons.check_circle, color: Colors.green)
                      : null,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
