import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Text("Second Screen"),
        ),
      ),
    );
  }
}
