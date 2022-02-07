import 'package:checkpay/api/field.dart';

class Data{

   final String? date;
   final String? matricule;

   Data({this.date,this.matricule});


  Map<String,dynamic> toJson()=>{
     Fields.date: date,
     Fields.matricule: matricule
   };
}

