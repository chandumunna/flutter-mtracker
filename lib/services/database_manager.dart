// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/transaction.dart';

class DatabaseManager {
  String version = '1.0';
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String TRANSACTION_COLLECTION_NAME = 'Transaction';

  static Stream<QuerySnapshot> getAllTransaction() => _db
      .collection(TRANSACTION_COLLECTION_NAME)
      .orderBy('timestamp', descending: true)
      .snapshots();

  static Stream<QuerySnapshot> getOutgoingTransaction() => _db
      .collection(TRANSACTION_COLLECTION_NAME)
      .where('type', isEqualTo: 'Outgoing')
      .snapshots();

  static String getUniqueId() =>
      DateTime.now().millisecondsSinceEpoch.toString();

  static Future<void> addTransaction(TransactionModel model) => _db
      .collection(TRANSACTION_COLLECTION_NAME)
      .doc(model.id)
      .set(model.toJson());

  static Future<void> deleteTransaction(TransactionModel model) =>
      _db.collection(TRANSACTION_COLLECTION_NAME).doc(model.id).delete();

  static Future<List<String>> getAllNotes() =>
      _db.collection(TRANSACTION_COLLECTION_NAME).get().then(
            (value) =>
                value.docs.map((e) => e['note'] as String).toSet().toList(),
          );

  static Future<List<String>> getAllNotesOfType(String type) => _db
          .collection(TRANSACTION_COLLECTION_NAME)
          .where('type', isEqualTo: type)
          .get()
          .then(
        (value) {
          final List<String> trans =
              value.docs.map((e) => TransactionModel.fromDoc(e).note).toList();
          final occurrence = <String, int>{};
          for (final t in trans) {
            occurrence[t] = occurrence.containsKey(t) ? occurrence[t]! + 1 : 1;
          }

          final output = occurrence.keys.toList(growable: false);
          output.sort((k1, k2) => occurrence[k2]!.compareTo(occurrence[k1]!));
          return output.take(10).toList();
        },
      );
}
