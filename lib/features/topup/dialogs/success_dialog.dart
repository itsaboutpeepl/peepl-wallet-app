import 'package:flutter/material.dart';
import 'package:peepl/features/shared/widgets/primary_button.dart';

class TopUpSuccess extends StatefulWidget {
  final String amountText;
  final bool showOrderNow;
  TopUpSuccess(this.amountText, this.showOrderNow);
  @override
  _TopUpSuccessState createState() => _TopUpSuccessState();
}

class _TopUpSuccessState extends State<TopUpSuccess>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  bool isPreloading = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext _context) {
    return ScaleTransition(
        scale: scaleAnimation,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          title: Text(
            "💸 Success!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '£' + widget.amountText + ' Topped Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Thanks for topping up your Peepl Wallet!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'You can now go ahead and enjoy one of the Peepl Eat Experiences this weekend 😋',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                widget.showOrderNow
                    ? SizedBox(height: 20.0)
                    : SizedBox.shrink(),
                widget.showOrderNow
                    ? Center(
                        child: PrimaryButton(
                          label: 'Order now',
                          fontSize: 20,
                          // labelFontWeight: FontWeight.normal,
                          onPressed: () async {
                            // Navigator.of(context).pop();
                            // final BottomNavigationBar navigationBar =
                            //     AppKeys.bottomBarKey.currentWidget;
                            // navigationBar.onTap(2);
                            // ExtendedNavigator.named('topupRouter')
                            //     .popUntilRoot();
                          },
                        ),
                      )
                    : SizedBox.shrink()
              ],
            ),
          ),
        ));
  }
}
