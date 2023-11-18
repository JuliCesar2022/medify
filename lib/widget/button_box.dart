import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String textButton;

  const CustomButton({
    super.key,
    this.onPressed,
    required this.textButton,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: size.width * 0.6,
        decoration: BoxDecoration(
            // color: const Color.fromARGB(255, 18, 121, 255),
            borderRadius: BorderRadius.circular(30)),
        child: MaterialButton(
          height: 45,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
          color: const Color.fromARGB(255, 18, 121, 255),
          onPressed: widget.onPressed,
          child: Text(
            widget.textButton,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
