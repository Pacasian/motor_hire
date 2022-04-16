import 'package:flutter/material.dart';

Padding nwTF(TextEditingController _controller,String _hintText){

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      enabled: true, // to trigger disabledBorder
      decoration:const InputDecoration(
        filled: true,
        fillColor: Color(0xFFF2F2F2),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1,color: Colors.red),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1,color: Colors.orange),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1,color: Colors.green),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1,)
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1,color: Colors.black)
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
        ),
        hintText: "",
        hintStyle: TextStyle(fontSize: 16,color: Color(0xFFB3B1B1)),
      ),
      controller: _controller,
      obscureText: false,
    ),
  );
 }

