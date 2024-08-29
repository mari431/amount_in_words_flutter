import 'package:amount_in_words_flutter/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountInWords extends StatefulWidget {
  const AmountInWords({super.key});

  @override
  State<AmountInWords> createState() => _AmountInWordsState();
}

class _AmountInWordsState extends State<AmountInWords> {
  final TextEditingController _amount = TextEditingController();

  String? _amountInWords = '-';
  bool isConvert = false;

  Future<void> numberToWords(String number) async {
    setState(() {
      isConvert = true;
    });
    double numberVal = double.parse(number);
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _amountInWords = Utility.convertNumberToWords(numberVal);
      isConvert = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Amount in words'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 350,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.lightGreenAccent.shade100,Colors.purpleAccent.shade100],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft),
                    // border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(child: Text('$_amountInWords',style: TextStyle(color: Colors.black,fontSize: 25,decorationColor: Color.fromARGB(0, 255, 255, 255)),))),
              SizedBox(height: 5,),
              Container(
                width: 300,
                child: TextFormField(
                  controller: _amount,
                  keyboardType: TextInputType.number,
                  maxLength: 15,
                  inputFormatters: [
                    // FilteringTextInputFormatter.allow(RegExp('[.]')), // Deny the dot character
                    // FilteringTextInputFormatter.deny(RegExp('[.]')), // Deny the dot character
                    FilteringTextInputFormatter.allow(
                        RegExp('^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$')),
                  ],
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                  counterText: 'maximum length - 15'),
                  onChanged: (val){
                    numberToWords(val);
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    numberToWords(_amount.text);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: isConvert == true
                      ? CircularProgressIndicator(
                          color: Colors.black,
                        )
                      : Text('Convert',style: TextStyle(color: Colors.white),))
            ],
          ),
        ),
      ),
    ));
  }
}
