import 'package:flutter/material.dart';

class BottomBarItem extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const BottomBarItem(
    this.icon,
    this.title, {
    this.onTap,
    this.color = const Color(0xFFABBEEC),
    this.activeColor = Colors.black,
    this.isActive = false,
    this.isNotified = false,
  });
  final IconData icon;
  final String title;
  final Color color;
  final Color activeColor;
  final bool isNotified;
  final bool isActive;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          isNotified
              ? Stack(children: <Widget>[
                  Icon(
                    icon,
                    size: 26,
                    color: isActive ? activeColor : activeColor.withOpacity(.4),
                  ),
                  const Positioned(
                    top: 5.0,
                    right: 0,
                    left: 8.0,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(
                        Icons.brightness_1,
                        size: 10.0,
                        color: Colors.red,
                      ),
                    ),
                  )
                ])
              : Icon(
                  icon,
                  size: 26,
                  color: isActive ? activeColor : activeColor.withOpacity(.4),
                ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: isActive ? activeColor : activeColor.withOpacity(.5),
            ),
          ),
        ],
      ),
    );
  }
}
