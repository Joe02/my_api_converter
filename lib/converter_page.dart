import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_converter/converter_widget.dart';
import 'package:url_launcher/url_launcher.dart';

///Link de requisição https://api.hgbrasil.com/finance?format=json&key=884e5329

class ConverterPage extends StatefulWidget {
  @override
  ConverterPageState createState() => ConverterPageState();
}

class ConverterPageState extends State<ConverterPage> {
  http.Response response;
  dynamic responseJson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showInfoDialog();
        },
        backgroundColor: Colors.purple,
        child: Icon(Icons.live_help, color: Colors.white,),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Conversor"),
      ),
      body: FutureBuilder(
        future: getFinancesRequest(),
        builder: (context,snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting: {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Divider(),
                    Text("Carregando valores...")
                  ],
                ),
              );
          }
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text("Erro ao carregar os valores :("),
                );
              } else {
                var dolar = snapshot.data['results']['currencies']['USD']['buy'];
                var euro = snapshot.data['results']['currencies']['EUR']['buy'];
                return SingleChildScrollView(
                  child: ConverterWidget(dolar, euro),
                );
              }
          }
        }
      ),
    );
  }

  showInfoDialog() {
    // configura o button
    Widget navUpButton = FlatButton(
      child: Text("Voltar"),
      onPressed: () { },
    );

    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("API Utilizada"),
      content: GestureDetector(
          onTap: () async {
            final apiUrl = "https://hgbrasil.com/status/finance";
            if (await canLaunch(apiUrl)) {
              launch(apiUrl);
            }
          },
          child: Text("https://hgbrasil.com/status/finance", style: TextStyle(color: Colors.lightBlueAccent),)),
      actions: [
        navUpButton,
      ],
    );

    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  getFinancesRequest() async {
    response = await http.get('https://api.hgbrasil.com/finance?format=json&key=884e5329');
    responseJson = json.decode(response.body);
    return responseJson;
  }
}