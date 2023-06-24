import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:list_with_chart/Transaction.dart';
import 'package:list_with_chart/chart_bar.dart';

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

  double get maxspend {
    return groupedTransaction.fold(0.0, (sum, item) {
      dynamic amount = item['amount'];
      return sum + amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      child: Container(
        margin: EdgeInsets.only(top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransaction.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
              data['day'].toString() ,
              data['amount']as double,
              maxspend== 0.0 ? 0.0:(data['amount'] as double)/maxspend,
            ),
          );
        }).toList()),
      ),
    );
  }
}
