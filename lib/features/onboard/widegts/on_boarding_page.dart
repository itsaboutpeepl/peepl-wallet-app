import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class WelcomeFrame extends StatelessWidget {
  const WelcomeFrame(
    this.title,
    this.subTitle,
    this.img, {
    Key? key,
  }) : super(key: key);

  final String title;
  final String img;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Padding(
        padding: EdgeInsets.only(top: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/' + img,
              width: MediaQuery.of(context).size.width * .8,
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0, top: 30),
              child: Text(
                title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AutoSizeText.rich(
                TextSpan(children: [
                  TextSpan(
                    text: subTitle,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondaryVariant,
                    ),
                  ),
                ]),
                minFontSize: 16,
                maxFontSize: 20,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
