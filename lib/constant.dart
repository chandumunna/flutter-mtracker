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
