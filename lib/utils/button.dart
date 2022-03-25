import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String title;
  final Color accent;
  final double radius;
  final VoidCallback callback;

  const DefaultButton(
      {Key key,
      @required this.title,
      this.accent = const Color(0xFFDD1313),
      this.radius = 20,
      @required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 20,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        color: accent,
        onPressed: callback,
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class DefaultButtonIcon extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color accent;
  final Color background;
  final double radius;
  final VoidCallback callback;

  const DefaultButtonIcon(
      {Key key,
      @required this.icon,
      @required this.title,
      this.accent = Colors.white,
      this.background = const Color(0xFFDD1313),
      this.radius = 20,
      @required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton.icon(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        color: background,
        onPressed: callback,
        icon: Icon(
          icon,
          color: accent,
        ),
        label: Text(
          title,
          style: TextStyle(color: accent, fontSize: 16),
        ),
      ),
    );
  }
}
