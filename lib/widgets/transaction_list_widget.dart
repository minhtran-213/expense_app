import 'package:expenses_transaction_app/models/transaction.dart';
import 'package:expenses_transaction_app/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransactions;
  TransactionsList(this.transactions, this.removeTransactions);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transaction added yet!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(height: 50),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return TransactionCard(
                  removeTransactions: removeTransactions,
                  transaction: transactions[index]);
            },
            itemCount: transactions.length,
          );
  }
}
