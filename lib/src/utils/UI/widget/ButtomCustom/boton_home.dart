import 'package:flutter/material.dart';

class BotonHome extends StatefulWidget {
  final String imagen; 
  final String Text;
  final double padding; 
  VoidCallback? onpresed;
  BotonHome({super.key, required this.imagen, required this.Text, this.onpresed, this.padding= 10.0});

  @override
  State<BotonHome> createState() => _BotonHomeState();
}

class _BotonHomeState extends State<BotonHome> {
  
  @override
  Widget build(BuildContext context) {
    final size =  MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.padding),
      child: MaterialButton(
         child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, children:  [Text(widget.Text),  Image.asset(widget.imagen, fit: BoxFit.cover,height: 80,), ]) ,

                
                    
         onPressed: widget.onpresed,
         color: Colors.blue, 
         minWidth: size.width,
         height: 85,
         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
         ),);
  }
}