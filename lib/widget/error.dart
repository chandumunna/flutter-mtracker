import 'package:flutter/material.dart';

class ErrorDetailWidget extends StatelessWidget {
  final String error;

  const ErrorDetailWidget(this.error, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(error));
  }
}
