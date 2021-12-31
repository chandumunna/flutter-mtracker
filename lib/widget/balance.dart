import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/transaction.dart';
import '../../services/database_manager.dart';
import '../all_transaction.dart';
import '../constant.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO : Need to add all transaction list....
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AllTransaction(),
          ),
        );
      },
      child: Material(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.amber,
        elevation: cardElevation,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Balance',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.black),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: DatabaseManager.getAllTransaction(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: LinearProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      final List<DocumentSnapshot<Object?>> allTransactions =
                          snapshot.data!.docs;

                      num totalSum = 0;
                      for (final element in allTransactions) {
                        final TransactionModel model =
                            TransactionModel.fromDoc(element);
                        totalSum += model.amount;
                      }

                      return Text(
                        '${formatAtm(totalSum)}/-',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.black),
                      );
                    } else {
                      return const Center(
                        child: Text('Error while loading Transaction'),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
