import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton({super.key});

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

const double width = 340.0;
const double height = 30.0;
const double loginAlign = -1;
const double signInAlign = 1;
const Color selectedColor = Colors.white;
const Color normalColor = Colors.grey;

class _ToggleButtonState extends State<ToggleButton> {
  late double xAlign;
  late Color noteColor;
  late Color statColor;

  @override
  void initState() {
    super.initState();
    xAlign = loginAlign;
    noteColor = selectedColor;
    statColor = normalColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.all(
          Radius.circular(50.0),
        ),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: Alignment(xAlign, 0),
            duration: const Duration(milliseconds: 220),
            child: Container(
              width: width * 0.5,
              height: height * 1.1,
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                xAlign = loginAlign;
                noteColor = selectedColor;
                statColor = normalColor;
              });
            },
            child: Align(
              alignment: const Alignment(-1, 0),
              child: Container(
                width: width * 0.5,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.book, // Replace with the desired icon
                      color: noteColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Дневник настроения',
                      style: TextStyle(
                        fontSize: 12,
                        color: noteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                xAlign = signInAlign;
                statColor = selectedColor;
                noteColor = normalColor;
              });
            },
            child: Align(
              alignment: Alignment(1, 0),
              child: Container(
                width: width * 0.5,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bar_chart, // Replace with the desired icon
                      color: statColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Статистика',
                      style: TextStyle(
                        color: statColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
