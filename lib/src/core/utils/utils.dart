
import 'package:track_jira_task/src/core/error/failures.dart';



String? extractSemanticVersioning(String? v) {
  if (v == null) return null;
  List<String> split = v.split("-");
  if (split.length == 0) return null;
  return split[0];
}

int? appVersionToInt(String? v) {
  if(v == null) return 1;
  List<String> split1 = v.split("-");
  if(split1.length > 0){
    List<String> split2 = split1[0].split(".");
    split2.removeLast();
    if(split2.length > 0) {
      String _v = '';
      split2.forEach((e) {
        _v += e;
      });
      return (int.tryParse(_v) ?? 0) * 10;
    }
  }
  return 1;
}

String? mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return (failure as ServerFailure).message;
    case CacheFailure:
      return (failure as CacheFailure).get.message;
      // ignore: dead_code
      break;
    default:
      return 'Unexpected error';
  }
}
