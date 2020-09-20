import 'dart:math';

import 'package:expense_tracker/models/transactionModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;

  @override
  void initState() {
    super.initState();
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.purple,
    ];

    _bgColor = availableColors[Random().nextInt(4)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: FittedBox(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: _bgColor,
                    child: Text(
                      "\$${widget.transaction.amount.toStringAsFixed(1)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      widget.transaction.title.toString(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Container(
                    child: Text(
                      DateFormat("MMM dd, yyyy")
                          .format(widget.transaction.dateTime),
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => widget.deleteTx(widget.transaction.id),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
