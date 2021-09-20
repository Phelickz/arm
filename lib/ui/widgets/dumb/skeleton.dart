
import 'package:arm_test/app/utils/res.dart';
import 'package:flutter/material.dart';

import 'busy.dart';

class Skeleton extends StatelessWidget {
  final bool? automaticallyImplyLeading;
  final bool? isBusy;
  final Color? backgroundColor;
  final String? appBarTitle;
  final TextStyle? appBarTitleStyle;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? belowOverlayChild;
  final List<Widget>? appBarActions;
  final Widget? appBarLeading;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final EdgeInsets? bodyPadding;
  final Widget? appBarTitleWidget;
  final BoxConstraints? constraints;
  final bool? centerTitle;
  final String? busyText;
  final double? leadingWidth;
  final PreferredSizeWidget? appBar;

  const Skeleton({
    Key? key,
    @required this.isBusy,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.appBarTitle,
    this.appBarTitleStyle,
    @required this.body,
    this.floatingActionButton,
    this.floatingActionButtonAnimator,
    this.floatingActionButtonLocation,
    this.belowOverlayChild,
    this.appBarActions,
    this.appBarLeading,
    this.drawer,
    this.endDrawer,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.bodyPadding,
    this.appBarTitleWidget,
    this.constraints,
    this.centerTitle = false,
    this.busyText,
    this.leadingWidth,
    this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isBusy!,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
              backgroundColor: backgroundColor,
              appBar: appBar ?? null,
              body: Container(
                padding: bodyPadding ??
                    EdgeInsets.symmetric(
                      horizontal: McGyver.rsDoubleW(context, 5),
                    ),
                child: body,
              ),
              floatingActionButton: floatingActionButton ?? null,
              floatingActionButtonAnimator: floatingActionButtonAnimator,
              floatingActionButtonLocation: floatingActionButtonLocation,
              drawer: drawer,
              endDrawer: endDrawer,
              bottomNavigationBar: bottomNavigationBar,
              bottomSheet: bottomSheet,
            ),
          ),
          isBusy!
              ? Busy(
                  text: busyText ?? '',
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
