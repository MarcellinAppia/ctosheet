import 'package:checkpay/api/field.dart';
import 'package:gsheets/gsheets.dart';

class Gsheetapi{

  //on genere les access depuis l'api

static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "gsheetfl",
  "private_key_id": "c84da36b6fd643992eadffaf770c1a9d84ccb4fe",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCpt9OuWd5KS7E2\nl/2DnyWHpSURLe06tMHuPOUvZ8i0J180yYvvPAvs2amZMz8QxPGLIksC/oaXNfzU\nTyISCekHT1qRPDHRFuuH2Lh6j70oyDPeyXS0XQDvDbQ5tMosS9DyXECXE902Kw27\nDmxyKSiQkYHRxBG1FH/DdmFkLKA1qVB5OuaDBuKAz3durQEn/B9pomsFiA1D2qhO\neApbZ95tnRpl0Sdsx8LQy+157B4P1ezgfZBlcj1tN/qljn9nlVa1/jB1lB5YhHjJ\newDw/wdOjXntiDGp1a8rudi+ROTQUb/PNMj+SPfdO60jhYdDzoZNmfDeCc6cTsi8\n/rff+3h7AgMBAAECggEAFjvESedxBQekeBPyPK95IauDTxxWoyWx8C1fEtZER0GP\nKeGraNRTdZxQKQc7IE3EnOcJr6M7a4zBieix/G367p+5LCSYHB2mDl5YUIoLDFAp\n52o51TUH3clMTnD+OU5XWaC3P3N1O9bpDhPGJjB5JXNCcAIBFdlRIYCdIpvsAwts\nIxWI2IGmGqvrFrmO9RJmByrvh472QM3X1WYLqsK3qnOsM1qsj1ovj8q5bJ3UVS7k\ng1DR0Uw/rAsPZCTaRTPg6sWNe9+jZdseyBj4hclJQWfAxGSK2MbCf0RstJjnZ30m\n9r9kl8fCiojlQ6qgJIwFGwUFf/o7Lo+qVHHsISnuxQKBgQDV+XPGCLoFFlNf9lqH\nGkhcI73wNOf4LYgX2/7GoyZ0JECI/j+0pW50CmMrMzsaAS9LnNNudwcpL4uwQAv6\n4RQvwzMOVf8KylgeY9CuD0kKpirAiR5/g5cL6Rd9XS61iqHLNuv6nTfJwlo+cpDg\nxwaVOMOXYyMkKe66X/gjBEsSbwKBgQDLDS7o1i8Ha2iNpfQsPYTqin0+s93Ltnh5\nLqCIUjkGEG3yea+oAKazwN6XkSdVhNOiSWyk+gfB1Lj+srr+t32V2dZDOSW6m/py\n9d8F4noYyPnlFfQHLhVkRQHN5L5XdGzHDSEfoJVOxsRG0rZtLDGcdSE8c9tvR5sz\n6l57XIeQtQKBgEptdoPPzUSvu1iJzHtp/PlvxUWkYXvF+qyx7TES1vFXGsuMBITF\ndmIOquf/7fLhrp3ScwjdhjQhQamQ3ZnqaKckcsHtz8TlFTmc5p1k27dEjWJjT6Rz\nFTsjXPRSUUj8a8LP281Umm8nl1RZbWOCVxvYntAtv694ln1lnF4xxBspAoGBAMJe\nwUvTU7uHftMxTDZZQXX+0fuG1EcgSdy+3J8CDmIWshjNkW+CCBHEC5ANPBjqCGiu\nXpjiWzCZv+jYEJap8UbT+v3oo4wpqaoIYNBSRsyY/lXkGPASlhmg0SRV1jsDUOmO\nUOnkn2iEbvjY1hZVmrwJh6JFyYWRhylALedq4L6NAoGAToPFG9CIc4p9pKezyKIy\n5JbMmN6N/I9GZH9yUJrE64YUkzg7/KUikuNwvcsP6nrG9qkNY8Hu8dgcnp/Q6xvn\nw1FdmU3svI6qSMzYmCwm4OpLSXwd8J5fmbdyQUTNff6BJkEBCIK75sh/NyFwjyTn\nPcE7BgEvUhWXaQxZ0axhwTI=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheetfl@gsheetfl.iam.gserviceaccount.com",
  "client_id": "106594911592983488636",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheetfl%40gsheetfl.iam.gserviceaccount.com"
}

''';

//on recupere l'id de la page 
  static final _sheetId = '1M9tSb0nYDv-ZeF69VOOsljCDrqGAokLBcKYYVtBItZ4';

  //on initialise le package avec les acces
  static final _gsheets = GSheets(_credentials);

//integration de la feuille active dans une variable
  static Worksheet? _pageActive;

  static Future init() async{

    try{
      final spreadsheet = await _gsheets.spreadsheet(_sheetId);

        _pageActive = await _getWorkSheet(spreadsheet,title:'cohorte');

        final firstRow = Fields.getFields();
        _pageActive!.values.insertRow(1,firstRow);

    }catch(e){
      print('erreur d\'initialisation');
    }

  }

 
 static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,{
  required String title
  })async{
    try{
      return await spreadsheet.addWorksheet(title);
    }catch(e){
      return spreadsheet.worksheetByTitle(title)!;
    }
  }


  static Future insert(List<Map<String, dynamic>> mesDonnees)async{
    _pageActive!.values.map.appendRows(mesDonnees);
  }
   
}

