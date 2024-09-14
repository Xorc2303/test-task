import 'package:flutter/material.dart';
import 'package:test_task/toggle_button.dart';
import 'package:test_task/emotion_model.dart';
import 'package:test_task/calendar.dart';
import 'package:test_task/feel_slider.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<FeelingsModel> feelings = [];
  List<FeelingsModel> selectedFeel = [];
  late List<bool> isSelected;
  List<String> selectedSubFeel = [];
  bool _isSlider1Touched = false;
  bool _isSlider2Touched = false;
  bool _isItemSelected = false;

  @override
  void initState() {
    super.initState();
    _getFeelings();
    isSelected = List.filled(feelings.length, false);
  }

  double _levelStress = 3;
  double _selfEsteem = 3;

  void _getFeelings() {
    feelings = FeelingsModel.getFeelings();
  }

  @override
  Widget build(BuildContext context) {
    _getFeelings();

    final now = DateTime.now();
    final formattedDate = DateFormat('d MMMM HH:mm').format(now);

    return Scaffold(
      backgroundColor: const Color(0xfdfbfaff),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 25, bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Spacer(),
                Text(
                  formattedDate,
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey[600],
                      fontFamily: 'Nunito'),
                ),
                const Spacer(),
                IconButton(
                  iconSize: 30,
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Calendar()));
                  },
                  icon: const Icon(Icons.calendar_month_rounded),
                ),
              ],
            ),
            const ToggleButton(),
            const Text(
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              'Что чувствуешь?',
            ),
            Container(
              height: 110,
              color: Colors.white12,
              child: ListView.separated(
                itemCount: feelings.length,
                separatorBuilder: (context, index) => const SizedBox(width: 25),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected[index] = !isSelected[index];
                        selectedFeel = List.from(
                          feelings.where(
                                (feel) => isSelected[feelings.indexOf(feel)],
                          ),
                        );
                        _isItemSelected = selectedFeel.isNotEmpty; // Update the state
                        _updateButtonState();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: AnimatedContainer(
                        duration: Duration.zero,
                        margin: const EdgeInsets.all(3),
                        width: 83,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300]!,
                              blurRadius: 1,
                              spreadRadius: 1.0,
                              offset: const Offset(0, 3),
                            )
                          ],
                          border: Border.all(
                            color: isSelected[index]
                                ? Colors.orange
                                : Colors.transparent,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(76),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 53,
                              child: Image.asset(feelings[index].iconPath),
                            ),
                            Text(
                              style: const TextStyle(fontSize: 11),
                              feelings[index].name,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (selectedFeel.isNotEmpty) _buildSelectedFeelingsList(),
            const Text(
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              'Уровень стресса',
            ),
            FeelSlider(
              currentValue: _levelStress,
              onValueChanged: (value) {
                setState(() {
                  _levelStress = value;
                  _isSlider1Touched = true;
                  _updateButtonState();
                });
              },
            ),
            const Text(
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              'Самооценка',
            ),
            FeelSlider(
              currentValue: _selfEsteem,
              onValueChanged: (value) {
                setState(() {
                  _selfEsteem = value;
                  _isSlider2Touched = true;
                  _updateButtonState();
                });
              },
              leftLabel: 'Неуверенность',
              rightLabel: 'Уверенность',
            ),
            const Text(
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              'Заметки',
            ),
            Container(
              height: 100,
              width: 335,
              margin: const EdgeInsets.only(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF1F3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                style: TextStyle(
                    fontFamily: 'RobotoMedium',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF252525)),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(
                      Icons.search_outlined,
                      color: Color(0xFF2C2C2C),
                      weight: 5,
                    ),
                    hintText: 'Введите заметку',
                    hintStyle: TextStyle(
                      fontFamily: 'OpenSansRegular',
                      fontSize: 16,
                    ),
                    enabledBorder:
                    OutlineInputBorder(borderSide: BorderSide.none),
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  (_isSlider1Touched && _isSlider2Touched && selectedSubFeel.isNotEmpty) ? Colors.orange : Colors.grey[400],
                ),
                minimumSize: MaterialStateProperty.all(const Size(335, 44)),
                overlayColor: MaterialStateProperty.all(
                  (_isSlider1Touched && _isSlider2Touched && selectedSubFeel.isNotEmpty) ? Colors.orange.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                ),
              ),
              onPressed: (_isSlider1Touched && _isSlider2Touched && selectedSubFeel.isNotEmpty)
                  ? () {print('pop-up');}
                  : null,
              child: const Text(
                style: TextStyle(color: Colors.white),
                'Сохранить',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedFeelingsList() {
    return Container(
      margin: const EdgeInsets.only(top: 2),
      height: 108,
      child: ListView.builder(
        itemCount: selectedFeel.length,
        itemBuilder: (context, index) {
          final wubFeel = selectedFeel[index];
          return Wrap(
            children: wubFeel.subFeel.map((subFeel) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8, right: 8),
                height: 21,
                color: Colors.white,
                child: ChoiceChip(
                  padding: const EdgeInsets.only(bottom: 10),
                  side: const BorderSide(color: Colors.white, width: 0),
                  elevation: 0.5,
                  backgroundColor: Colors.white,
                  selectedColor: Colors.orange,
                  label: Text(style: const TextStyle(fontSize: 11), subFeel),
                  selected: selectedSubFeel.contains(subFeel),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        if (!selectedSubFeel.contains(subFeel)) {
                          selectedSubFeel.add(subFeel);
                        }
                      } else {
                        selectedSubFeel.remove(subFeel);
                      }
                      _updateButtonState();
                    });
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  void _updateButtonState() {
    setState(() {
      _isItemSelected = selectedFeel.isNotEmpty && selectedSubFeel.isNotEmpty;
    });
  }
}
