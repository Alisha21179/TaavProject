import 'package:flutter/material.dart';

class BackgroundStack extends StatefulWidget {
  final List<Widget> widgetList;
  const BackgroundStack({Key? key,required this.widgetList}) : super(key: key);

  @override
  State<BackgroundStack> createState() => _BackgroundStackState();
}

class _BackgroundStackState extends State<BackgroundStack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          children: [
            ..._positionedList(),
            ...widget.widgetList,
          ],
        ),
      ),
    );
  }

  List<Positioned> _positionedList() {
    return [
      Positioned(
        top: -500,
        right: -300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 500,
              child: Expanded(
                child: CircleAvatar(
                  radius: 500,
                  backgroundColor: Colors.red.withOpacity(0.9),
                ),
              ),
            ),
          ],
        ),
      ),
      Positioned(
        top: 50,
        right: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: Expanded(
                child: CircleAvatar(
                  radius: 150,
                  backgroundColor: Colors.red.withOpacity(0.9),
                ),
              ),
            ),
          ],
        ),
      ),
      Positioned(
        top: 230,
        right: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 180,
              child: Expanded(
                child: CircleAvatar(
                  radius: 200,
                  backgroundColor: Colors.red.withOpacity(0.9),
                ),
              ),
            ),
          ],
        ),
      ),
      Positioned(
        top: 350,
        right: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: Expanded(
                child: CircleAvatar(
                  radius: 300,
                  backgroundColor: Colors.red.withOpacity(0.9),
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
