import 'package:flutter/material.dart';
import 'package:flutter_calculator/widgets/display_widget.dart';
import 'package:flutter_calculator/widgets/pad_widget.dart';

/*TODO 
1. length over width
- decima : toStringExponent
- int : fade overflowText form start

2. clearAndChangeNum after percentage also can operate with new num 
3. addDisplayNum after wrote decimal with '.'
4. inner boxShadow 

  */

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String displayNum = '0';
  String? currentOperator;
  String storedNum = '0';
  bool isAllClear = true;
  bool isClearAndChangeNum = true;

  void onChangeDisplayNum(String newNum) {
    setState(() {
      displayNum = isClearAndChangeNum ? newNum : displayNum + newNum;
    });

    isAllClear = false;
    isClearAndChangeNum = false;
  }

  void onChangeOperator(String operator) {
    if (isClearAndChangeNum) {
      return;
    }
    isClearAndChangeNum = true;

    if (currentOperator != null) {
      String result = operate[currentOperator]!();
      List<String> doubleDigits = result.split('.');
      print(doubleDigits);
      if (doubleDigits.length == 2 && doubleDigits[1] == '0') {
        print('yes');
        doubleDigits = doubleDigits.sublist(0, doubleDigits.length - 1);
      }

      result = doubleDigits.join('.');

      setState(() {
        displayNum = result;
      });
      storedNum = result;
    } else {
      storedNum = displayNum;
    }
    currentOperator = operator == '=' ? null : operator;
  }

  void onChangeSubOperator(String operator) {
    subOperate[operator]!();
  }

  late final operate = <String, String Function()>{
    '+': sum,
    '-': subtract,
    '/': divide,
    '*': multiply,
  };

  late final subOperate = <String, void Function()>{
    'C': clear,
    'AC': allClear,
    '+/-': addNegativeOnDisplayNum,
    '%': getPercentage,
  };

  String sum() {
    return (double.parse(displayNum) + double.parse(storedNum)).toString();
  }

  String subtract() {
    return (double.parse(storedNum) - double.parse(displayNum)).toString();
  }

  String multiply() {
    return (double.parse(displayNum) * double.parse(storedNum)).toString();
  }

  String divide() {
    return (double.parse(storedNum) / double.parse(displayNum)).toString();
  }

  void clear() {
    setState(() {
      displayNum = '0';
      isAllClear = true;
      isClearAndChangeNum = true;
    });
  }

  void allClear() {
    setState(() {
      displayNum = '0';
    });
    storedNum = '0';
    currentOperator = null;
    isClearAndChangeNum = true;
  }

  void addNegativeOnDisplayNum() {
    String newDisplayNum = (-double.parse(displayNum)).toString();
    List<String> doubleDigits = newDisplayNum.split('.');
    if (doubleDigits.length == 2 && doubleDigits[1] == '0') {
      newDisplayNum = doubleDigits[0];
    }
    isClearAndChangeNum = true;
    onChangeDisplayNum(newDisplayNum);
  }

  void getPercentage() {
    List<String> doubleDigits = displayNum.split('.');
    String newDisplayNum = (double.parse(doubleDigits[0]) * 0.01).toString();
    if (doubleDigits.length == 2) {
      newDisplayNum = '0.0${doubleDigits.join('')}';
    }

    isClearAndChangeNum = true;

    onChangeDisplayNum(newDisplayNum);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.yellow,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(2, 3)),
              const BoxShadow(
                color: Colors.red,
              )
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Display(
                  displayNum: displayNum,
                ),
              ),
              Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: Pad(
                  onChangeNum: onChangeDisplayNum,
                  onChangeOperator: onChangeOperator,
                  onChangeSubOperator: onChangeSubOperator,
                  isAllClear: isAllClear,
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
