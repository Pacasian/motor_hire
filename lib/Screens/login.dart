import 'package:flutter/material.dart';

import '../Widget/google_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
  Size size= MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        color: Colors.grey.shade300,
        height: size.height,
        child: Center(
          child: Container(
            width: 500,
            height: 300,
            child: Card(
              elevation: 4,
              color: Colors.grey.shade100,
              child: Column(
                children: [
                  Container(
                    height: 80,
                    width: 500,
                    decoration:const BoxDecoration(
                    color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(4),topRight: Radius.circular(4))
                    ),
                    child: Center(child: Text("Motor Hire: Car Rental",style: Theme.of(context).textTheme.headline5,)),
                  ),
                  Expanded(child: Container(
                    height: 250,
                    child: Center(
                      child: GoogleButton(),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
