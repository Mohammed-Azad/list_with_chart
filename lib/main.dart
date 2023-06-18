import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:list_with_chart/Transaction.dart';
import './Transaction.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
  ));
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
  void resetcontroller() {
    titlecontroler.clear();
    amountcontroler.clear();
  }


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
          title: Text("Expenses App",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple[300]),),
          actions: [
            IconButton(
                icon: const Icon(Icons.add_rounded),
                onPressed: () {
                  resetcontroller();
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 400,
                        padding: EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 20,),
                              Center(child: Text("Add Expense",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.deepPurple[400]),),),
                              TextField(
                                decoration: InputDecoration(labelText: "Title"),
                                controller: titlecontroler,
                                textInputAction: TextInputAction.next,
                              ),
                              TextField(
                                  decoration:
                                      InputDecoration(labelText: "Amount"),
                                  controller: amountcontroler,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.number,
                                  onSubmitted: (value) {
                                    if (amountcontroler.text != "0" &&
                                        !titlecontroler.text.isEmpty) {
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
                                      } catch (e) {}

                                      Navigator.of(context).pop();
                                    }
                                  }),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    if (amountcontroler.text != "0" &&
                                        !titlecontroler.text.isEmpty) {
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
                                        resetcontroller();
                                      } catch (e) {}
                                    }
                                  },
                                  child: Text("Add Transactions"),
                                ),
                              ),
                            ]),
                      );
                    },
                  );
                }),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              width: double.infinity,
              child: SizedBox(
                height: 15,
                child: Container(
                  child: Text("chart in here "),
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.only(left: 125),
                ),
              ),
            ),
            Container(
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
