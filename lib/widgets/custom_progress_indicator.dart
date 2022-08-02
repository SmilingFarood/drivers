import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  const CustomProgressIndicator({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  Widget _platform() {
    if (Platform.isAndroid) {
      return const CircularProgressIndicator();
    } else {
      return const CupertinoActivityIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if (isLoading) {
      final modal = Stack(
        children: [
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.grey),
          ),
          Center(child: _platform()),
        ],
      );
      widgetList.add(modal);
    }

    return Stack(
      children: widgetList,
    );
  }
}
