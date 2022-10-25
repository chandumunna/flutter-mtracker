import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtracker/constant.dart';
import 'package:mtracker/edit_transaction.dart';
import 'package:mtracker/model/transaction.dart';
import 'package:mtracker/services/database_manager.dart';

class TransactionListWidget extends StatefulWidget {
  const TransactionListWidget({
    Key? key,
    required this.allTransactions,
    required this.canPin,
  }) : super(key: key);

  final List<DocumentSnapshot> allTransactions;
  final bool canPin;

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
                Navigator.pushNamed(
                  context,
                  EditTransaction.route,
                  arguments: transactionModel,
                );
              },
              onLongPress: () {
                if (widget.canPin) {
                  DatabaseManager.togglePin(transactionModel);
                }
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
