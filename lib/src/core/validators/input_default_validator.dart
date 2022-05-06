import 'package:formz/formz.dart';

enum InputDefaultError { empty, outOfRange }

class InputDefault extends FormzInput<String, InputDefaultError>{
  final int? maxLenght;

  InputDefault.pure({this.maxLenght}) : super.pure('');
  InputDefault.dirty({String value = '', this.maxLenght}) : super.dirty(value);

  @override
  InputDefaultError? validator(String? value) {
    if(value?.length == 0) return InputDefaultError.empty;
    
    if(value != null && maxLenght != null){
      if(value.length > maxLenght!) return InputDefaultError.outOfRange;
    }

    return value?.isNotEmpty == true ? null : InputDefaultError.empty;
  }

  InputDefault copyWith({
    String? value,
    int? maxLenght,
  }){
    return InputDefault.dirty(
      value: value ?? this.value,
      maxLenght: maxLenght ?? this.maxLenght
    );
  }
}