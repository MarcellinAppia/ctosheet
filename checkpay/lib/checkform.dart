import 'package:checkpay/api/data.dart';
import 'package:checkpay/api/field.dart';
import 'package:checkpay/api/gsheetapi.dart';
import 'package:checkpay/dfield.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Checkform extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('CheckForm'),
      ),body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Check Monsieur'),
          Padding(
            padding: const EdgeInsets.only(left:50.0, right: 50, top: 10),
            child: Center(child: dfield()),
          ),
          Padding(
            padding: const EdgeInsets.only(left:50.0, right: 50),
            child: Center(
              child: TextFormField(
              decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter votre matricule',
              ),
             ),
            ),
          ),
        
       Padding(
         padding: const EdgeInsets.only(top:10.0),
        
         child: TextButton(child: Text("CHECK"),
         style: TextButton.styleFrom(primary: Colors.amber),
         onPressed: () async{
           final data = Data(
              date: "1010",
              matricule: '22222');

           await Gsheetapi.insert([data.toJson()]);
           
         },
         ),
       )
        ],
      )
      ,),
    );
  }
}