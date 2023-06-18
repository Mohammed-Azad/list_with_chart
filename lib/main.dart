import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:list_with_chart/Transaction.dart';
import './Transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Transaction> transactions = [
    Transaction(id: "0", title: "Mouse", amount: 5, date: DateTime.now()),
    Transaction(id: "1", title: "keyboard", amount: 20, date: DateTime.now())
  ];

  final titlecontroler = TextEditingController();

  final amountcontroler = TextEditingController(text: "0");

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("ListWithChart"),
        ),
        body: SingleChildScrollView(
          
          child: Column(children: [
            Container(
              width: double.infinity,
              height: 50,
              child: Container(
                child: Text("chart in here "),
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.only(left: 125),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          decoration: InputDecoration(labelText: "Title"),
                          controller: titlecontroler,
                        ),
                        TextField(
                          decoration: InputDecoration(labelText: "Amount"),
                          controller: amountcontroler,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              if (amountcontroler.text != "0") {
                                try {
                                  setState(() {
                                    transactions.add(
                                      Transaction(
                                          id: (transactions.length + 1)
                                              .toString(),
                                          amount: double.parse(
                                              amountcontroler.text),
                                          date: DateTime.now(),
                                          title: titlecontroler.text),
                                    );
                                  });
                                  amountcontroler.clear();
                                  titlecontroler.clear();
                                } catch (e) {}
                              }
                            },
                            child: Text("Add Transactions"),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            Container(
              height: 300,
              child: SingleChildScrollView(
                child: Column(
                  children: transactions.map((e) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          e.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        ),
                        subtitle: Text(
                          e.date.toString(),
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        trailing: Text("\$${e.amount.toString()}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.deepPurple)),
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
