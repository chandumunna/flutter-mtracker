import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mtracker/constant.dart';
import 'package:mtracker/model/transaction.dart';
import 'package:mtracker/services/database_manager.dart';
import 'package:mtracker/widget/loading.dart';

class MonthlyStatsWidget extends StatelessWidget {
  const MonthlyStatsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseManager.getOutgoingTransaction(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        } else {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Error : while fetch outgoing transaction from firebase",
              ),
            );
          } else {
            final List<DocumentSnapshot<Object?>> allTransactions =
                snapshot.data!.docs;

            final List<TransactionModel> allTransactionsModel = allTransactions
                .map((e) => TransactionModel.fromDoc(e))
                .toList();
            final List<TransactionModel> currentMonthOutgoing =
                outgoingTransactionOnMonth(allTransactionsModel);
            final num totalSum = getTotalSum(currentMonthOutgoing);
            final List<Map<String, dynamic>> items =
                noteItems(currentMonthOutgoing);

            return Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        Text(
                          'This month stats',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          '${formatAtm(totalSum)}/-',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                ...List.generate(
                  items.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      color: Colors.blue.shade100,
                      elevation: cardElevation,
                      borderRadius: BorderRadius.circular(5.0),
                      child: ListTile(
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 110,
                              child: FittedBox(
                                child: Text(
                                  "${formatAtm(items[index]['value'] as num)} (${(((items[index]['value'] as num) * -1) / totalSum * 100).toStringAsFixed(2)}%)",
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: LinearProgressIndicator(
                                value: ((items[index]['value'] as num) * -1) /
                                    totalSum,
                              ),
                            ),
                          ],
                        ),
                        title: Text("${items[index]['key']}"),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        }
      },
    );
  }

  List<TransactionModel> outgoingTransactionOnMonth(
    List<TransactionModel> allTransactionsModel,
  ) {
    final String currentMonth =
        '${DateTime.now().month}-${DateTime.now().year}';
    final List<TransactionModel> currentMonthOutgoing =
        allTransactionsModel.where((element) {
      return element.date.contains(currentMonth);
    }).toList();
    return currentMonthOutgoing;
  }

  List<Map<String, dynamic>> noteItems(
    List<TransactionModel> currentMonthOutgoing,
  ) {
    final Map<String, num> items = {};
    for (final element in currentMonthOutgoing) {
      items[element.note] = items.containsKey(element.note)
          ? items[element.note]! + element.amount
          : element.amount;
    }
    final List<Map<String, dynamic>> itemList = [];
    items.forEach((key, value) {
      itemList.add({'key': key, 'value': value});
    });
    itemList.sort((a, b) => (a['value'] as num).compareTo(b['value'] as num));
    return itemList;
  }

  num getTotalSum(List<TransactionModel?> currentMonthOutgoing) {
    num totalSum = 0;
    for (final model in currentMonthOutgoing) {
      totalSum += model!.amount;
    }
    return totalSum * -1;
  }
}
