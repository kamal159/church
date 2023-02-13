import 'package:flutter/material.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              customShape(
                -50,
                -50,
                null,
                null,
                const Center(
                    child: Text(
                  'logout',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontStyle: FontStyle.italic),
                )),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customButton(color: const Color(0xff02133E), text: 'logout'),
              customButton(color: const Color(0xff0047FF), text: 'Back'),
            ],
          ),
          customShape(null, null, -50, -50, null),
        ],
      ),
    );
  }

  Widget customShape(double? top, double? right, double? left, double? bottom,
          Widget? child) =>
      Positioned(
        top: top,
        right: right,
        left: left,
        bottom: bottom,
        child: Container(
          width: 225,
          height: 225,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: Colors.blue,
          ),
          child: child,
        ),
      );

  Widget customButton({
    required Color color,
    required String text,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: color),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    text,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
