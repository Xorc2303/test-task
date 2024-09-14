import 'package:flutter/material.dart';

class FeelSlider extends StatefulWidget {
  final double currentValue;
  final ValueChanged<double> onValueChanged;
  final String leftLabel;
  final String rightLabel;

  const FeelSlider({
    super.key,
    required this.currentValue,
    required this.onValueChanged,
    this.leftLabel = 'Низкий',
    this.rightLabel = 'Высокий',
  });

  @override
  _FeelSliderState createState() => _FeelSliderState();
}

class _FeelSliderState extends State<FeelSlider> {
  bool _isTouched = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 335,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 1,
            spreadRadius: 1.0,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return Container(
                  height: 10,
                  width: 3,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(25),
                  ),
                );
              }),
            ),
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: Colors.orange,
              inactiveTrackColor: Colors.grey[300],
              thumbColor: _isTouched ? Colors.orange : Colors.grey[400],
              overlayColor: Colors.orange.withOpacity(0.2),
              trackHeight: 6.0,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 13.0),
              tickMarkShape: const RoundSliderTickMarkShape(),
              activeTickMarkColor: Colors.grey[400],
              inactiveTickMarkColor: Colors.grey[400],
            ),
            child: Slider(
              value: _isTouched ? widget.currentValue : 0.0,
              min: 0,
              max: 6,
              divisions: 5,
              onChanged: (value) {
                setState(() {
                  _isTouched = true;
                });
                widget.onValueChanged(value);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.leftLabel,
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
                Text(
                  widget.rightLabel,
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
