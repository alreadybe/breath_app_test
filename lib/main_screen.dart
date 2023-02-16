import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _timeSelected;
  late String _practiceTypeSelected;
  late double _paceSelected;

  final List<String> _practiceTypes = [
    'Resonance',
    'Balance',
    'Strength',
    'Focus'
  ];
  final List<double> _paceTypes = [7.5, 7, 6, 5, 5.5, 4, 3, 2.1];
  final List<int> _timeTypes = List.generate(31, (index) => index);

  final ScrollController _practiceController = ScrollController();
  final ScrollController _paceController = ScrollController();
  final ScrollController _timeController = ScrollController();

  @override
  void initState() {
    super.initState();
    _timeSelected = 0;
    _practiceTypeSelected = 'Resonance';
    _paceSelected = 7.5;
  }

  @override
  Widget build(BuildContext context) {
    _practiceController.addListener(() {
      final index = _practiceController.offset / 175;
      setState(() {
        _practiceTypeSelected = index.round() > _practiceTypes.length - 1
            ? _practiceTypes.last
            : _practiceTypes[index.round()];
      });
    });

    _paceController.addListener(() {
      final index = _paceController.offset / 145;
      setState(() {
        _paceSelected = index.round() > _paceTypes.length - 1
            ? _paceTypes.last
            : _paceTypes[index.round()];
      });
    });

    _timeController.addListener(() {
      final index = _timeController.offset / 10;
      setState(() {
        _timeSelected = index.round() > _timeTypes.length - 1
            ? _timeTypes.last
            : _timeTypes[index.round()];
      });
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Flexible(
              child: Column(
            children: [
              _timeSelected != 0
                  ? Text(
                      '$_timeSelected min',
                      style: const TextStyle(color: Colors.white, fontSize: 32),
                    )
                  : Image.asset(
                      'assets/icon.png',
                      width: 50,
                      height: 50,
                      color: Colors.white,
                    ),
              Flexible(
                child: ListView.builder(
                  itemCount: _timeTypes.length,
                  controller: _timeController,
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 3),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          index == 0
                              ? Image.asset(
                                  'assets/icon.png',
                                  width: 20,
                                  height: 20,
                                  color: Colors.white,
                                )
                              : const SizedBox(
                                  height: 20,
                                ),
                          Text(
                            '|',
                            textAlign: TextAlign.center,
                            style: index % 10 == 0
                                ? TextStyle(
                                    color: _timeSelected == _timeTypes[index]
                                        ? Colors.white
                                        : Colors.grey,
                                    fontSize: 22)
                                : TextStyle(
                                    color: _timeSelected == _timeTypes[index]
                                        ? Colors.white
                                        : Colors.grey[700],
                                    fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
          Flexible(
              child: ListView.builder(
            itemCount: _practiceTypes.length,
            controller: _practiceController,
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 3),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Row(
              children: [
                Text(
                  _practiceTypes[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: _practiceTypeSelected == _practiceTypes[index]
                          ? Colors.white
                          : Colors.grey,
                      fontSize: 34),
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
          )),
          Flexible(
              child: ListView.builder(
            itemCount: _paceTypes.length,
            controller: _paceController,
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 3),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Row(
              children: [
                Text(
                  '${_paceTypes[index]} bpm',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: _paceSelected == _paceTypes[index]
                          ? Colors.white
                          : Colors.grey,
                      fontSize: 34),
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
          )),
        ]),
      ),
    );
  }
}
