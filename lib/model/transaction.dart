import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  String id;
  String note;
  num amount;
  String type;
  Timestamp timestamp;
  String date;
  String description;
  bool pin;
  List searchIndex;

  TransactionModel({
    required this.id,
    required this.note,
    required this.amount,
    required this.type,
    required this.timestamp,
    required this.date,
    required this.description,
    required this.pin,
    required this.searchIndex,
  });

  TransactionModel.fromDoc(DocumentSnapshot doc)
      : id = doc['id'] as String,
        note = doc['note'] as String,
        amount = doc['amount'] as num,
        type = doc['type'] as String,
        timestamp = doc['timestamp'] as Timestamp,
        date = doc['date'] as String,
        description = doc['description'] as String,
        pin = doc['pin'] as bool,
        searchIndex = doc['search_index'] as List;

  Map<String, Object> toJson() => {
        'id': id,
        'note': note,
        'amount': amount,
        'type': type,
        'timestamp': timestamp,
        'date': date,
        'description': description,
        'pin': pin,
        'search_index': searchIndex,
      };
}
