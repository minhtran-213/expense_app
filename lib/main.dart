import 'package:expenses_transaction_app/widgets/chart.dart';
import 'package:expenses_transaction_app/widgets/new_transaction.dart';
import 'package:expenses_transaction_app/widgets/transaction_list_widget.dart';

import 'package:flutter/material.dart';

import 'models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(
                color: Colors.white,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transaction_list = [];
  bool _showChart = false;
  List<Transaction> get _recentTransactions {
    return _transaction_list.where(
      (transaction) {
        return transaction.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTransaction = Transaction(
      title: title,
      amount: amount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(
      () {
        _transaction_list.add(newTransaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transaction_list.removeWhere((element) => element.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _isLanscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var appBar2 = AppBar(
      title: Text('Flutter App'),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );
    var txList = Container(
        height: (MediaQuery.of(context).size.height -
                appBar2.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionsList(_recentTransactions, _deleteTransaction));
    return Scaffold(
      appBar: appBar2,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_isLanscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart'),
                  Switch(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      }),
                ],
              ),
            if (!_isLanscape)
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar2.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: Chart(_transaction_list)),
            if (!_isLanscape) txList,
            if (_isLanscape)
              _showChart
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                          appBar2.preferredSize.height -
                          MediaQuery.of(context).padding.top),
                      child: Chart(_transaction_list))
                  : txList,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
