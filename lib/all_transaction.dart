import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mtracker/services/database_manager.dart';
import 'package:mtracker/widget/error.dart';
import 'package:mtracker/widget/loading.dart';
import 'package:mtracker/widget/transaction_list_widget.dart';

class AllTransaction extends StatelessWidget {
  static const route = '/transactions';
  const AllTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Transaction'),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: DatabaseManager.getAllTransaction(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingWidget();
            } else {
              if (snapshot.hasData) {
                final List<DocumentSnapshot<Object?>> allTransactions =
                    snapshot.data!.docs;

                if (allTransactions.isEmpty) {
                  return const ErrorDetailWidget('No Transaction Found');
                }
                return TransactionListWidget(
                  allTransactions: allTransactions,
                  canPin: true,
                );
              } else {
                return const ErrorDetailWidget(
                  'Error while loading Transaction',
                );
              }
            }
          },
        ),
      ),
    );
  }
}
