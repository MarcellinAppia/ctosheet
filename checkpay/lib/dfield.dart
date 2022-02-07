
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class dfield extends StatefulWidget {

  const dfield({ Key? key }) : super(key: key);
 
  @override
  _dfieldState createState() => _dfieldState();
}

class _dfieldState extends State<dfield> {
  DateTime? selectedData;
   final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  //final String formatted = formatter.format(now);
  @override
  Widget build(BuildContext context) { 
    return DateTimeField(
  
      decoration: InputDecoration(
        hintText: 'Entrez la date svp',
        fillColor: Colors.amber),
      mode: DateTimeFieldPickerMode.date,
      dateFormat: DateFormat('dd/MM/yyyy') ,
            selectedDate: selectedData,
            onDateSelected: (DateTime value) {
              setState(() {
                selectedData = value;
              });
            },
           
          );
       }
}