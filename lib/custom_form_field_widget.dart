import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomFormFieldWidget extends StatefulWidget {
  final focusNode;
  final labelText;
  final prefixText;
  final textEditingController;
  final updatableFunction;

  CustomFormFieldWidget(this.focusNode, this.labelText, this.prefixText, this.textEditingController, this.updatableFunction);

  @override
  CustomFormFieldWidgetState createState() => CustomFormFieldWidgetState();
}

class CustomFormFieldWidgetState extends State<CustomFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(hintColor: Colors.purple),
      child: TextFormField(
        controller: widget.textEditingController,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        onChanged: (value) {
          widget.updatableFunction(value);
        },
        focusNode: widget.focusNode,
        keyboardType: TextInputType.numberWithOptions(),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.purple,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.purpleAccent,
              width: 1.0,
            ),
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: widget.focusNode.hasFocus
                  ? Colors.purpleAccent
                  : Colors.purple),
          prefixText: widget.prefixText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

}