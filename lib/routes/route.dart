import 'package:flutter/material.dart';
import 'package:mtracker/add_transaction.dart';
import 'package:mtracker/all_transaction.dart';
import 'package:mtracker/edit_transaction.dart';
import 'package:mtracker/home.dart';
import 'package:mtracker/login.dart';
import 'package:mtracker/model/transaction.dart';
import 'package:mtracker/start.dart';

class RouteGenerator {
  static const String initRoute = '/';
  // Route<dynamic>? Function(RouteSettings settings)
  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const StartScreen(),
          settings: settings,
        );
      case LoginScreen.route:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
          settings: settings,
        );
      case HomeScreen.route:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
          settings: settings,
        );
      case AllTransaction.route:
        return MaterialPageRoute(
          builder: (context) => const AllTransaction(),
          settings: settings,
        );
      case EditTransaction.route:
        return MaterialPageRoute(
          builder: (context) => EditTransaction(
            transactionModel: settings.arguments! as TransactionModel,
          ),
          settings: settings,
        );
      case AddTransaction.route:
        return MaterialPageRoute(
          builder: (context) => AddTransaction(
            transactionType:
                (settings.arguments! as Map)['transactionType'] as String,
            chips: (settings.arguments! as Map)['value'] as List<String>,
          ),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text(
                "😔\n404\nPage not found",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(color: Colors.black),
              ),
            ),
          ),
        );
    }
  }
}
