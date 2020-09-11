import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_converter/custom_form_field_widget.dart';

class ConverterWidget extends StatefulWidget {
  final dolar;
  final euro;

  ConverterWidget(this.dolar, this.euro);

  @override
  ConverterWidgetState createState() => ConverterWidgetState();
}

class ConverterWidgetState extends State<ConverterWidget> {
  FocusNode brlFocusNode = new FocusNode();
  FocusNode dolarFocusNode = new FocusNode();
  FocusNode euroFocusNode = new FocusNode();

  final brlTextController = TextEditingController();
  final dolarTextController = TextEditingController();
  final euroTextController = TextEditingController();

  var brlQuantity;
  var dolarQuantity;
  var euroQuantity;

  onBrlChanged(String newValue) {
    setState(() {
      var brlQuantity = double.parse(newValue);
      print(brlQuantity);
      dolarTextController.text =
          (brlQuantity / widget.dolar).toStringAsFixed(2);
      euroTextController.text = (brlQuantity / widget.euro).toStringAsFixed(2);
    });
  }

  onDolarChanged(String newValue) {
    setState(() {
      var dolarQuantity = double.parse(newValue);
      print(dolarQuantity);
      brlTextController.text =
          (dolarQuantity * widget.dolar).toStringAsFixed(2);
      euroTextController.text =
          (dolarQuantity * widget.dolar / widget.euro).toStringAsFixed(2);
    });
  }

  onEuroChanged(String newValue) {
    setState(() {
      var euroQuantity = double.parse(newValue);
      print(euroQuantity);
      brlTextController.text = (euroQuantity * widget.euro).toStringAsFixed(2);
      euroTextController.text =
          (euroQuantity * widget.euro / widget.dolar).toStringAsFixed(2);
    });
  }

  @override
  void initState() {
    super.initState();

    brlTextController.addListener(() {
      if (brlQuantity == 0 || brlQuantity == null) {
        dolarTextController.clear();
        euroTextController.clear();
      }
    });

    brlTextController.addListener(() {
      if (dolarQuantity == 0 || dolarQuantity == null) {
        dolarTextController.clear();
        euroTextController.clear();
      }
    });

    brlTextController.addListener(() {
      if (euroQuantity == 0 || euroQuantity == null) {
        dolarTextController.clear();
        euroTextController.clear();
      }
    });

    brlFocusNode.addListener(() {
      setState(() {});
    });
    dolarFocusNode.addListener(() {
      setState(() {});
    });
    euroFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: <Widget>[
          CustomFormFieldWidget(
              brlFocusNode, "REAIS", "R\$ ", brlTextController, onBrlChanged),
          Divider(
            height: 10,
            color: Colors.transparent,
          ),
          CustomFormFieldWidget(dolarFocusNode, "DOLÁRES", "US\$ ",
              dolarTextController, onDolarChanged),
          Divider(
            height: 10,
            color: Colors.transparent,
          ),
          CustomFormFieldWidget(
              euroFocusNode, "EUROS", "€ ", euroTextController, onEuroChanged),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    brlFocusNode.dispose();
    dolarFocusNode.dispose();
    euroFocusNode.dispose();
  }
}
