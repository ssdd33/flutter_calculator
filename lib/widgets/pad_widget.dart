import 'package:flutter/material.dart';

class Pad extends StatelessWidget {
  void Function(String) onChangeNum;
  void Function(String) onChangeOperator;
  void Function(String) onChangeSubOperator;
  bool isAllClear;

  Pad({
    super.key,
    required this.onChangeNum,
    required this.onChangeOperator,
    required this.onChangeSubOperator,
    required this.isAllClear,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Flexible(
        flex: 3,
        fit: FlexFit.tight,
        child: Column(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Row(children: [
                PadItem(
                    isAllClear ? 'AC' : 'C', onChangeSubOperator, Colors.grey),
                ...['+/-', '%']
                    .map((op) => PadItem(op, onChangeSubOperator, Colors.grey))
                    .toList(),
              ]),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Row(
                children: [
                  ...[
                    '7',
                    '8',
                    '9',
                  ]
                      .map((num) => PadItem(
                            num,
                            onChangeNum,
                            Colors.lightGreen,
                          ))
                      .toList(),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Row(
                children: [
                  ...[
                    '4',
                    '5',
                    '6',
                  ]
                      .map((num) => PadItem(
                            num,
                            onChangeNum,
                            Colors.lightGreen,
                          ))
                      .toList(),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Row(
                children: [
                  ...[
                    '1',
                    '2',
                    '3',
                  ]
                      .map((num) => PadItem(
                            num,
                            onChangeNum,
                            Colors.lightGreen,
                          ))
                      .toList(),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Row(
                children: [
                  PadItem('0', onChangeNum, Colors.lightGreen, 2),
                  PadItem('.', onChangeNum, Colors.lightGreen),
                ],
              ),
            ),
          ],
        ),
      ),
      Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
            child: Column(
              children: [
                ...['+', '-', '/', '*', '=']
                    .map((op) => PadItem(op, onChangeOperator, Colors.orange))
                    .toList()
              ],
            ),
          ))
    ]);
  }
}

Widget PadItem(String label, void Function(String) callback, Color color,
    [int flex = 1]) {
  return Flexible(
      fit: FlexFit.tight,
      flex: flex,
      child: GestureDetector(
        onTap: () {
          callback(label);
        },
        child: Container(
            decoration: BoxDecoration(color: color),
            child: Center(
              child: Text(label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  )),
            )),
      ));
}
