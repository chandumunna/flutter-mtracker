import 'package:flutter/material.dart';
import 'package:mtracker/services/database_manager.dart';
import 'package:mtracker/widget/balance.dart';
import 'package:mtracker/widget/monthly_stats.dart';
import 'package:mtracker/widget/search_btn.dart';
import 'package:mtracker/widget/transaction_buttons.dart';
import 'package:mtracker/widget/welcome.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.2,
            vertical: 20,
          ),
          content: const Text(
            'Fetched data from ${DatabaseManager.TRANSACTION_COLLECTION_NAME}',
            textAlign: TextAlign.center,
          ),
        ),
      );
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: const [
                  WelcomeWidget(),
                  SizedBox(height: 25),
                  BalanceWidget(),
                  SizedBox(height: 25),
                  TransactionButtonsWidget(),
                  SizedBox(height: 25),
                  SearchBtn(),
                  SizedBox(height: 25),
                  MonthlyStatsWidget(),
                ],
              ),
      ),
    );
  }
}
