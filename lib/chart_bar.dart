import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spending;
  final double spendingPrecentTotal;

  const ChartBar(this.label, this.spending, this.spendingPrecentTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('\$${spending.toStringAsFixed(0)}',style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 100,
          width: 25,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            FractionallySizedBox(
              heightFactor: spendingPrecentTotal,
              child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5)),),
            ),
          ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
            Container(child:Text(label),
            ),
      ],
    );
  }
}
