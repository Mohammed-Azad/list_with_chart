import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:list_with_chart/Transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  const Chart(this.recentTransaction);
  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalsum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekday.day &&
            recentTransaction[i].date.month == weekday.month &&
            recentTransaction[i].date.year == weekday.year) {
          totalsum += recentTransaction[i].amount;
        }
      }
      // print(DateFormat.E().format(weekday));
      // print(totalsum);
      return {
        'day': DateFormat.E().format(weekday).substring(0, 2),
        'amount': totalsum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      child: Row(
          children: groupedTransaction.map((data) {
        return Text('${data['day']}: ${data['amount']}');
      }).toList()),
    );
  }
}
