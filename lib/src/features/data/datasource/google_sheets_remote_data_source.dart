import 'package:gsheets/gsheets.dart';
import 'package:track_jira_task/src/core/http/api.dart';
import 'package:track_jira_task/src/features/domain/entities/task_entity.dart';

abstract class GoogleSheetsRemoteDataSource{
  Future<void> setTaskGsheets(TaskEntity task);
  Future<void> updateTaskGsheets(TaskEntity task);
}

class GoogleSheetsRemoteDataSourceImpl extends ApiProvider implements GoogleSheetsRemoteDataSource{

  //Credenciales GSheets
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "jira-gsheets-348413",
  "private_key_id": "33b26985b1668bc52192845275984f9862fa3d88",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDCUPZYx9xr6wL5\nMbEkl1QNAzL6Xhd/Nunekdvx7KPyVJatprQnh4KGQIFxzhlYzRFcwaRGPzdIumxg\nUq1UB8RieszRwUpFYfm4oViKlCiWCngOCMHg9djw5qCPuwy8Heg3dZEePvBthVAY\njDbx7C7O0lbbCMGzPA3eft9ZuGf02MYZ2BuxzPHj+0jf1/lt1RahNZBBUYLtWId/\nFXKHHOvXHtQcqsjaPO1OaTqxEBX3Xycl+sWNHESkSvAkAUyOgm0OGxbGt6qj2JLv\n8EbgG1YtswaC+YfOKy4hcJwmZ/vG6d93F9nP4RRNXCLQ6DUlBLwuQKuUEslXwjX7\nL2+HjgP9AgMBAAECggEACkczCJYlvBWVti2hM5DHktqg9ypD7uguLaYkbqL4Nwiv\nYacIL3EU/9nonubqY06RhQj/EfIlD/VAZ0XoQiIZCqZ5L/0b2xioF1J9dvMIRItw\nNznSW35Vh8SDKKcZsNeaIVjYILPujrR2/J1qCJjYDvuEOZi4ei0KhMLMOJgu833u\nOZpTDZbYJzcCVKAX56EJelkR07HmGS/5Mgyu1qCLQL30nH3V35awRnID0XbVzdPQ\nSS9WDmN4/TXFUlp49uwZVn0Yxzpjj2YewlCCQ/dveOem9qaRkB2GFhC9QD6hfqrX\n1I1O82gmzi049mPPXPqYUL6m84onOnr2649Q2WaRRwKBgQDpyPlkGExryWbsxCSp\nJi85NEX6HiNF0cNqizyeg71Q769Pzo1eE1euoV1WJfpmmZKwKcckfux/m7hkOG3f\nhCj8ORPtokC83zdInY1DGHcxt2bmi5A6bwS4mywyM7dHZqGtZIDyStYe8UnUJnA4\nCSjSk9UGvLxsLQbdC3BTM5AGKwKBgQDUx+AI85G/9fAm0NKMvxEylS4yt1fnuyqX\n8pBHdExgSH7jbW5dyPVtj4WmxQIrPL4E0En83vUkXCavzVANMPfUQ6jfMeSTBcCN\n00WK9qsppLPkt3SC+RViidyhtKpMhXoxKEENy3zkkk/jPkI+jiUAginK3A5XNk/d\n08bolJRydwKBgB/YN1hSEv7PpUx0/0VnJSGWpD2Io2dcRlEZ/DzfVwdSTsABM7Jv\n0g7AfjVA4RXer2N9nVm0TESpknlcUmMS3n5UzAkfg8/2W9JxW4+bIolMISEgO5oq\nCyuWP3PrJXj9WuKCgSn/1aDLXzIdtkV7werFJkxPox7dF0U+zKMYr/KXAoGBALaL\nQwhq7X9h3sVuITPeN0LN+PRJloCXcdMppd2nSF7R0woJt8V9whBcMK0CFvpBAkPe\n7ZqjLGwlIotv+F1YxUS1Rws0IoR/StJhjifJts3jHvH48VvrlQ0UeNPBytgbKtlB\nT44mJN9zJlYt82b3S4dEI9aFM0her+X+6YZe8XvBAoGBAMaGsPyce5dLhOqc+De2\n2O6f1qtz6WhCs0yBXfwvIO8dY+0bueWuuidyX6dFH0z5NN4kmP9IAFTXfIJt60S9\n8JVw4WL6C3DHFqwY+Xib282OIysC6z2402OvXzVzHG44C3dM+YPPxV+riOf+H8fO\n5K1yYDRJL4k6EOf2nO8nrxGA\n-----END PRIVATE KEY-----\n",
  "client_email": "jira-gsheets@jira-gsheets-348413.iam.gserviceaccount.com",
  "client_id": "106439751015084667222",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/jira-gsheets%40jira-gsheets-348413.iam.gserviceaccount.com"
}
''';
  static const _spreadsheetId = '1ycpGdisal0uQQDGlhiAADJMjsaALWv9fuFbdcl2CP8Q';
// const _worksheetId = '0';
  static const _worksheetTitle = 'Worksheet1';

  @override
  Future<void> setTaskGsheets(TaskEntity task) async{
    //Iniciar GSheets
    final gsheets = GSheets(_credentials/*sl<Env>().api*/);
    //Obtener hoja de cálculo por Id
    final sheet = await gsheets.spreadsheet(_spreadsheetId/*EnvMode.spreadsheetId.toString()*/);
    //Hoja de trabajo por su titulo
    var workSheet = sheet.worksheetByTitle(_worksheetTitle/*EnvMode.worksheetTitle.toString()*/);

    await workSheet!.values.appendRow([task.id, task.activity, task.assignee, task.project, task.initDate.toString()]);

  }

  @override
  Future<void> updateTaskGsheets(TaskEntity task) async{
    //Iniciar GSheets
    final gsheets = GSheets(_credentials/*sl<Env>().api*/);
    //Obtener hoja de cálculo por Id
    final sheet = await gsheets.spreadsheet(_spreadsheetId/*EnvMode.spreadsheetId.toString()*/);
    //Hoja de trabajo por su titulo
    var workSheet = sheet.worksheetByTitle(_worksheetTitle/*EnvMode.worksheetTitle.toString()*/);


    //obtener filas
    final mapRow = await workSheet!.values.map.allRows();
    // log('$mapRow', name: 'map Row');
    //obtener indice de incidencia
    var index = mapRow?.asMap().entries.where((e) => e.value['Fecha_Fin'] == ''
        && e.value['Cod'] == task.id.toString()
        && e.value['Actividad'] == task.activity
        && e.value['Responsable'] == task.assignee
        && e.value['Proyecto'] == task.project
    ).toList();
    // log('$index', name: 'index');
    var indexOk = (index!.first.key);
    indexOk=indexOk+2;
    // log('$indexOk', name: 'index Ok');

    await workSheet.values.insertValue(task.endDate.toString(), column: 6, row: indexOk);

  }


}