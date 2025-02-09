import 'package:flutter/material.dart';
import 'package:peepl/features/home/widgets/balance.dart';
// import 'package:peepl/features/shared/widgets/barcode_scanner.dart';
import 'package:peepl/generated/l10n.dart';
import 'package:peepl/redux/viewsmodels/header.dart';
import 'package:peepl/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HeaderViewModel>(
      distinct: true,
      converter: HeaderViewModel.fromStore,
      builder: (_, viewModel) {
        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primaryVariant,
                Theme.of(context).colorScheme.primary,
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Flexible(
                child: Text(
                  '${I10n.of(context).hi} ${viewModel.firstName()}',
                  style: TextStyle(
                    color: Theme.of(context).canvasColor,
                    fontSize: 22,
                  ),
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      child: Balance(),
                    )
                    // BarcodeScanner(
                    //   child: Image.asset(
                    //     'assets/images/scan.png',
                    //     width: 25.0,
                    //     color: Theme.of(context).scaffoldBackgroundColor,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
