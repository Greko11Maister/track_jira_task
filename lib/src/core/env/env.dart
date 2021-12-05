import 'package:flagsmith/flagsmith.dart';

class Env {
  final EnvMode m;
  late FlagsmithClient flagsmithClient;
  Env(this.m){
    _initializeFlags();
  }

  static final String pathUrlImage = "https://api.yourmarket.app";
  static final String pathUrlAws = "https://your-market-empresa.s3.amazonaws.com";

  static final String _apiProduction = "https://test.miconjuntodigital.com";
  static final String _apiSandbox = "https://test.miconjuntodigital.com";
  static final String _apiLocal = "http://192.168.10.169:8001";

  String get api {
    switch (m) {
      case EnvMode.production:
        return _apiProduction;
      case EnvMode.sandbox:
        return _apiSandbox;
      case EnvMode.local:
        return _apiLocal;
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
    }
  }

  FlagsmithClient get flag {
    return flagsmithClient;
  }

  Future<void >_initializeFlags() async {
    String apikey = "iEnBDC45XuWyhqZmNXFebR";
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
    await flagsmithClient.getFeatureFlags(reload: true);
  }
}

enum EnvMode {
  production,
  sandbox,
  local,
}
