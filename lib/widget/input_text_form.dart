import 'package:flutter/material.dart';

class InputTextForm extends StatefulWidget {
  final String _placeholder;
  final bool _encryptation;
  final TextEditingController _textController;

  const InputTextForm(
      {super.key,
      required placeholder,
      bool encryptation = false,
      required textController})
      : _placeholder = placeholder,
        _encryptation = encryptation,
        _textController = textController;

  @override
  State<InputTextForm> createState() => _InputTextFormState();
}

class _InputTextFormState extends State<InputTextForm> {
  @override
  Widget build(BuildContext context) {
    // final focusNode = FocusNode();

    final outlineInputBorder = UnderlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(10));

    final inputDecoration = InputDecoration(
        hintText: widget._placeholder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        filled: true,
        fillColor: const Color.fromARGB(255, 58, 59, 60));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: widget._encryptation,
        onTapOutside: (event) {
          // focusNode.unfocus();
        },
        // focusNode: focusNode,
        controller: widget._textController,
        decoration: inputDecoration,
        onFieldSubmitted: (value) {
          // focusNode.requestFocus();
        },
      ),
    );
  }
}
