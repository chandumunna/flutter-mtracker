import 'package:intl/intl.dart';

const cardElevation = 10.0;
const collectionName = 'Transaction';
const dateTimeFormat = 'dd-MM-yyyy';

String formatDate(DateTime date) =>
    DateFormat(dateTimeFormat).add_jms().format(date);

String formatAtm(num atm) => NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
    ).format(atm);

List indexGenerator(String string) {
  final String s = string.toLowerCase().split(" ").join();
  final List ls = [];
  for (int i = 1; i < s.length; i++) {
    ls.add(s.substring(0, i));
  }
  for (int i = 0; i < s.length; i++) {
    ls.add(s.substring(i, s.length));
  }
  ls.addAll(s.split(""));
  return ls.toSet().toList();
}
