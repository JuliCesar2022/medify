import 'package:flutter/material.dart';

class MyMessage extends StatelessWidget {
  final Widget hora;
  final Widget message;
  const MyMessage({super.key, required this.message, required this.hora});

  @override
  Widget build(BuildContext context) {

    return Column(
      
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 23, 83, 113), borderRadius: BorderRadius.circular(10)),
          child:  Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                
                    message,
               
                    hora,
                  ],

            ),
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}