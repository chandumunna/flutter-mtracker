import 'package:flutter/material.dart';
import 'package:mtracker/add_transaction.dart';
import 'package:mtracker/constant.dart';
import 'package:mtracker/services/database_manager.dart';

class TransactionButtonsWidget extends StatelessWidget {
  const TransactionButtonsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () async {
            showDialog(
              context: context,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            );
            DatabaseManager.getAllNotesOfType('Incoming').then(
              (value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTransaction(
                    transactionType: 'Incoming',
                    chips: value,
                  ),
                ),
              ),
            );
          },
          child: Material(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.green.shade200,
            elevation: cardElevation,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                'Incoming',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.black),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            );
            DatabaseManager.getAllNotesOfType('Outgoing').then(
              (value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTransaction(
                    transactionType: 'Outgoing',
                    chips: value,
                  ),
                ),
              ),
            );
          },
          child: Material(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.red.shade200,
            elevation: cardElevation,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                'Outgoing',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
