import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mtracker/services/database_manager.dart';
import 'package:mtracker/widget/loading.dart';
import 'package:mtracker/widget/transaction_list_widget.dart';

class SearchTransaction extends StatefulWidget {
  static const route = '/search';
  const SearchTransaction({Key? key}) : super(key: key);

  @override
  State<SearchTransaction> createState() => _SearchTransactionState();
}

class _SearchTransactionState extends State<SearchTransaction> {
  String searchKey = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Transaction'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            if (searchKey == "")
              const Center(
                child: Text("Search notes"),
              )
            else
              StreamBuilder<QuerySnapshot>(
                stream: DatabaseManager.searchTransaction(searchKey),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingWidget();
                  }
                  final List<DocumentSnapshot<Object?>> allTransactions =
                      snapshot.data!.docs;

                  return TransactionListWidget(
                    allTransactions: allTransactions,
                    canPin: false,
                  );
                },
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      searchKey = value.toLowerCase();
                    });
                  },
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "Search for the note",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
