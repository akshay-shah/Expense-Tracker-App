import 'package:expense_tracker/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

import '../models/transactionModel.dart';

class TransactionCard extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTransaction;

  TransactionCard(this.transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "No transactions found!!",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              return TransactionItem(
                  transaction: transactions[index],
                  deleteTransaction: _deleteTransaction);
            },
            itemCount: transactions.length,
          );
  }
}
