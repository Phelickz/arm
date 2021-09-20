import 'package:arm_test/app/utils/res.dart';
import 'package:arm_test/app/utils/theme.dart';
import 'package:flutter/material.dart';

class CustomButtons {
  static Widget googleButton(
      {required BuildContext? context,
      required Function? onTap,
      required String text,
      Color textColor = Colors.white70}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context!).primaryColorDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),
      onPressed: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: CustomThemeData.generateStyle(
                fontSize: McGyver.textSize(context, 2.2),
                color: textColor,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Image.asset('assets/images/google.png')
          ],
        ),
      ),
    );
  }

  static Widget clearButton(
      {required BuildContext? context,
      required Function? onTap,
      required String text,
      Color textColor = Colors.white}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
         shadowColor: Colors.transparent,
         
          elevation: 0,
          primary: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
            side: BorderSide(
              width: 1,
              color: Theme.of(context!).primaryColor,
            ),
          ),
        ),
        onPressed: () {
          onTap!();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            text,
            style: CustomThemeData.generateStyle(
              fontSize: McGyver.textSize(context, 2.2),
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  static Widget gradientButton(
      {required BuildContext? context,
      required Function? onTap,
      required String text,
      Color textColor = Colors.white}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          gradient: CustomThemeData.buttonGradient),
      child: ElevatedButton(
        
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        onPressed: () {
          onTap!();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            text,
            style: CustomThemeData.generateStyle(
              fontSize: McGyver.textSize(context!, 2.2),
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  static Widget generalButton(
      {required BuildContext? context,
      required Function? onTap,
      required String text,
      Color textColor = Colors.white70}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context!).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        onPressed: () {
          onTap!();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            text,
            style: CustomThemeData.generateStyle(
              fontSize: McGyver.textSize(context, 2.2),
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
