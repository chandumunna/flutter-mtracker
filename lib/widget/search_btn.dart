import 'package:flutter/material.dart';
import 'package:mtracker/constant.dart';
import 'package:mtracker/search_transation.dart';

class SearchBtn extends StatelessWidget {
  const SearchBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SearchTransaction.route);
      },
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.blue,
        elevation: cardElevation,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: Text(
              'Search',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
