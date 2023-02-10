import 'package:flutter/material.dart';

class OTPForm extends StatelessWidget {
  const OTPForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(children: [
      // SizedBox(height: SizeConfig.screenHeight * 0.15),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
          width: 40,
          child: TextFormField(
            autofocus: true,
            obscureText: true,
            style: TextStyle(fontSize: 24),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(),
          ),
        ),
        SizedBox(
          width: 40,
          child: TextFormField(
            autofocus: true,
            obscureText: true,
            style: TextStyle(fontSize: 24),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(),
          ),
        ),
        SizedBox(
          width: 40,
          child: TextFormField(
            autofocus: true,
            obscureText: true,
            style: TextStyle(fontSize: 24),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(),
          ),
        ),
        SizedBox(
          width: 40,
          child: TextFormField(
            autofocus: true,
            obscureText: true,
            style: TextStyle(fontSize: 24),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(),
          ),
        ),
        SizedBox(
          width: 40,
          child: TextFormField(
            autofocus: true,
            obscureText: true,
            style: TextStyle(fontSize: 24),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(),
          ),
        ),
        SizedBox(
          width: 40,
          child: TextFormField(
            autofocus: true,
            obscureText: true,
            style: TextStyle(fontSize: 24),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(),
          ),
        ),
      ])
    ]));
  }
}
