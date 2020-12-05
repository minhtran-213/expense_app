import 'package:expenses_transaction_app/models/transaction.dart';
import 'package:expenses_transaction_app/widgets/transaction_list_widget.dart';
import 'package:flutter/material.dart';

import 'new_transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _transaction_list = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 9.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 10,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(),
        TransactionsList(_transaction_list),
      ],
    );
  }
}
