import 'package:flutter/material.dart';


class BuutomCustom extends StatefulWidget {
  final VoidCallback? onpresed;
  final Widget title; 
  final double width; 
  final Color? color;
   BuutomCustom( {super.key, this.onpresed, required this.title,  this.width= 200,Color color=Colors.blue }):
    this.color = color;
     

  @override
  State<BuutomCustom> createState() => _BuutomCustomState();
}

class _BuutomCustomState extends State<BuutomCustom> {
  @override
  Widget build(BuildContext context) {
 
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 10 ),
      child: SizedBox( width: widget.width ,
      child: MaterialButton(onPressed: widget.onpresed, 
      height: 50,
      color: widget.color,
      child:  widget.title ,
      shape: UnderlineInputBorder(borderRadius: BorderRadius.circular(15),) )),
    ) ;
  }
}