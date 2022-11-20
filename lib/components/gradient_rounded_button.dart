import 'package:flutter/material.dart';

class GradientRoundedButton extends StatelessWidget {
  const GradientRoundedButton({
    super.key,
    required this.colors,
    required this.onPressed,
    required this.child,
  });
  final List<Color> colors;
  final void Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 0, left: 35, right: 35),
      
      child: DecoratedBox
      (
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: colors),
            borderRadius: BorderRadius.circular(5),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                  blurRadius: 5) //blur radius of shadow
            ]),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              disabledBackgroundColor: Colors.transparent,
             shadowColor: Colors.transparent,
              //make color or elevated button transparent
            ),
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 18, bottom: 18, left: 25, right: 25),
              child: child,
            ))),
    );
      }
}
