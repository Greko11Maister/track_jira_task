class Env {
  final EnvMode m;
  //late FlagsmithClient flagsmithClient;
  Env(this.m){
    _initializeFlags();
  }

  static final String _apiProduction = "https://tribugbp.atlassian.net";
  static final String _apiSandbox = "https://tribugbp.atlassian.net";
  static final String _apiLocal = "http://192.168.10.169:8001";

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

  String get api {
    switch (m) {
      case EnvMode.production:
        return _apiProduction;
      case EnvMode.sandbox:
        return _apiSandbox;
      case EnvMode.local:
        return _apiLocal;
      case EnvMode.credentials:
        return _credentials;
      case EnvMode.spreadsheetId:
        return _spreadsheetId;
      case EnvMode.worksheetTitle:
        return _worksheetTitle;
    }
  }

  String get stage {
    switch (m) {
      case EnvMode.production:
        return "";
      case EnvMode.sandbox:
        return "-b.1";
      case EnvMode.local:
        return "-a.1";
      case EnvMode.credentials:
        return "";
      case EnvMode.spreadsheetId:
        return "";
      case EnvMode.worksheetTitle:
        return "";
    }
  }

  String get stageLabel {
    switch (m) {
      case EnvMode.production:
        return "";
      case EnvMode.sandbox:
        return "BETA";
      case EnvMode.local:
        return "ALPHA";
      case EnvMode.credentials:
        return "";
      case EnvMode.spreadsheetId:
        return "";
      case EnvMode.worksheetTitle:
        return "";
    }
  }

  bool get showBanner {
    switch (m) {
      case EnvMode.production:
        return false;
      case EnvMode.sandbox:
        return true;
      case EnvMode.local:
        return true;
      case EnvMode.credentials:
        return false;
      case EnvMode.spreadsheetId:
        return false;
      case EnvMode.worksheetTitle:
        return false;
    }
  }

  /*FlagsmithClient get flag {
    return flagsmithClient;
  }*/

  Future<void >_initializeFlags() async {
    /*String apikey = "iEnBDC45XuWyhqZmNXFebR";
    if(m == EnvMode.production){
      apikey = "YzFRgWadZS3BHRaJnn9rWR";
    }
    flagsmithClient = await FlagsmithClient.init(
      apiKey: apikey,
      config: FlagsmithConfig(
        caches: false,
        sendTimeout: 500
      ),
      seeds: <Flag>[
        Flag.seed('feature', enabled: true),
      ],
    );
    await flagsmithClient.getFeatureFlags(reload: true);*/
  }
}

enum EnvMode {
  production,
  sandbox,
  local,
  credentials,
  spreadsheetId,
  worksheetTitle
}
