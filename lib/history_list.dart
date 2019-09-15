import 'package:flutter/material.dart';
import 'package:vtb_pay_app/history_item.dart';

class HistoryList extends StatelessWidget {
  final Map<String, List<String>> data;

  const HistoryList(this.data);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        for (final item in data.entries)
          ExpansionTile(
            title: Text(item.key),
            children: <Widget>[
              for (final id in item.value)
                HistoryItem(id),
            ],
          ),
      ],
    );
  }
}
