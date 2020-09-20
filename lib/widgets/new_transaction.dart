import 'dart:io';

import 'package:expense_tracker/widgets/adaptive_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final titleText = _titleController.text;
    final amountText = double.parse(_amountController.text);
    final date = _selectedDate;
    if (titleText.isEmpty || amountText <= 0 || _selectedDate == null) {
      return;
    }
    widget.addNewTransaction(
      titleText,
      amountText,
      date,
    );
    Navigator.of(context).pop();
  }

  void _presenDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    print("initstate called");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose called");
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget called");
  }

  @override
  Widget build(BuildContext context) {
    print("build called");
    return SingleChildScrollView(
      child: Container(
        child: Card(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Platform.isIOS
                    ? CupertinoTextField(
                        placeholder: "Title",
                        controller: _titleController,
                        maxLength: 10,
                        onSubmitted: (_) => submitData(),
                      )
                    : TextField(
                        decoration: InputDecoration(
                          labelText: "Title",
                        ),
                        controller: _titleController,
                        maxLength: 10,
                        onSubmitted: (_) => submitData(),
                      ),
                Platform.isIOS
                    ? CupertinoTextField(
                        placeholder: "Amount",
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_) => submitData(),
                      )
                    : TextField(
                        decoration: InputDecoration(
                          labelText: "Amount",
                        ),
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_) => submitData(),
                      ),
                Container(
                  height: 80,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          _selectedDate == null
                              ? "No date selected"
                              : "Selected Date : ${DateFormat.yMd().format(_selectedDate)}",
                        ),
                      ),
                      AdaptiveFlatButton("Choose a Date", _presenDatePicker),
                    ],
                  ),
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: const Text(
                    "Add Transaction",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: submitData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
