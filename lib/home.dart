import 'package:flutter/material.dart';
import 'package:mtracker/widget/monthly_stats.dart';

import 'widget/balance.dart';
import 'widget/transaction_buttons.dart';
import 'widget/welcome.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
