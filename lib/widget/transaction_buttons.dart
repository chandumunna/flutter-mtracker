import 'package:flutter/material.dart';
import 'package:mtracker/services/database_manager.dart';

import '../add_edit_transaction.dart';
import '../constant.dart';

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
            // TODO : Incoming transaction form....
            DatabaseManager.getAllNotesOfType('Incoming').then(
              (value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditTransaction(
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
            // TODO : Outgoing transaction form....
            DatabaseManager.getAllNotesOfType('Outgoing').then(
              (value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditTransaction(
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
