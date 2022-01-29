import 'package:flutter/material.dart';
import 'package:mtracker/services/database_manager.dart';
import 'package:mtracker/widget/monthly_stats.dart';

import 'widget/balance.dart';
import 'widget/transaction_buttons.dart';
import 'widget/welcome.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Fetched data from ${DatabaseManager.TRANSACTION_COLLECTION_NAME}',
          ),
        ),
      );
    });
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            WelcomeWidget(),
            SizedBox(height: 25),
            BalanceWidget(),
            SizedBox(height: 25),
            TransactionButtonsWidget(),
            SizedBox(height: 25),
            MonthlyStatsWidget(),
          ],
        ),
      ),
    );
  }
}
