import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  String id;
  String note;
  num amount;
  String type;
  Timestamp timestamp;
  String date;
  String description;

  TransactionModel({
    required this.id,
    required this.note,
    required this.amount,
    required this.type,
    required this.timestamp,
    required this.date,
    required this.description,
  });

  TransactionModel.fromDoc(DocumentSnapshot doc)
      : id = doc['id'] as String,
        note = doc['note'] as String,
        amount = doc['amount'] as num,
        type = doc['type'] as String,
        timestamp = doc['timestamp'] as Timestamp,
        date = doc['date'] as String,
        description = doc['description'] as String;

  Map<String, Object> toJson() => {
        'id': id,
        'note': note,
        'amount': amount,
        'type': type,
        'timestamp': timestamp,
        'date': date,
        'description': description
      };
}
