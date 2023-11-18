import 'package:flutter/material.dart';

class MessagePersonGroup extends StatelessWidget {
  final String imagen ; 
  final Widget hora;
  final Widget message;
  const MessagePersonGroup({super.key, required this.message, required this.hora, required this.imagen});

  @override
  Widget build(BuildContext context) {

    return Row(
        
      children: [
        
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(backgroundImage: NetworkImage(imagen) , ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 3, 63, 103), borderRadius: BorderRadius.circular(10)),
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
          ),
        ),

      ],
    );
  }
}