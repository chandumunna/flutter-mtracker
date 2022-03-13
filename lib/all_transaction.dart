import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtracker/constant.dart';
import 'package:mtracker/edit_transaction.dart';
import 'package:mtracker/model/transaction.dart';
import 'package:mtracker/services/database_manager.dart';
import 'package:mtracker/widget/error.dart';
import 'package:mtracker/widget/loading.dart';

class AllTransaction extends StatelessWidget {
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
                return TransactionListWidget(allTransactions: allTransactions);
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

class TransactionListWidget extends StatefulWidget {
  const TransactionListWidget({
    Key? key,
    required this.allTransactions,
  }) : super(key: key);

  final List<DocumentSnapshot> allTransactions;

  @override
  State<TransactionListWidget> createState() => _TransactionLIstWidgetState();
}

class _TransactionLIstWidgetState extends State<TransactionListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.allTransactions.length,
      itemBuilder: (context, index) {
        final TransactionModel transactionModel =
            TransactionModel.fromDoc(widget.allTransactions[index]);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade200,
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTransaction(
                      transactionModel: transactionModel,
                    ),
                  ),
                );
              },
              onLongPress: () {
                DatabaseManager.togglePin(transactionModel);
              },
              child: ListTile(
                isThreeLine: true,
                leading: Icon(
                  Icons.label_important,
                  size: 30,
                  color: transactionModel.pin ? Colors.amber : Colors.grey,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    transactionModel.note,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Text(
                        transactionModel.description,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Chip(
                      label: Text(
                        formatDate(
                          transactionModel.timestamp.toDate(),
                        ),
                        softWrap: true,
                        style: GoogleFonts.oswaldTextTheme().caption!.copyWith(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                      ),
                    ),
                  ],
                ),
                trailing: Text(
                  formatAtm(transactionModel.amount),
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: transactionModel.type == 'Incoming'
                            ? Colors.green
                            : Colors.red,
                      ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
