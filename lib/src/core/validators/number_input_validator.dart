import 'package:formz/formz.dart';

enum NumberInputError { empty, outRange, onlyNumbers }
/// **validatorType**: 
/// 
/// - **0** -> validate the number of numbers
/// - **1** -> validate the number in a range  
///
/// **Warning!**, if validatorType is null return **NumberInputError.empty**
///
class NumberInput extends FormzInput<String?, NumberInputError> {
  final String? value;
  final int? validatorType;
  final double? start;
  final double? end;
  /// **validatorType**: 
  /// 
  /// - **0** -> validate the number of numbers
  /// - **1** -> validate the number in a range  
  ///
  /// **Warning!**, if validatorType is null return **NumberInputError.empty**
  ///
  const NumberInput.pure({this.value, this.validatorType = 0, this.start, this.end}) : super.pure('');
  /// **validatorType**: 
  /// 
  /// - **0** -> validate the number of numbers
  /// - **1** -> validate the number in a range  
  ///
  /// **Warning!**, if validatorType is null return **NumberInputError.empty**
  ///
  const NumberInput.dirty(this.value, {this.validatorType = 0, this.start, this.end}) : super.dirty('');

  NumberInput copyWith(
    String value, {
    int? validatorType,
    double? start,
    double? end,
  }) {
    return NumberInput.dirty(
      value,
      validatorType: validatorType ?? this.validatorType,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  //  type: 0 -> length
  //        1 -> number
  //
  //  if type is null return NumberInputError.empty
  @override
  NumberInputError? validator(String? value) {
    if (value == null || value == '') return NumberInputError.empty;

    if(!RegExp('^[0-9]+\$').hasMatch(value)) return NumberInputError.onlyNumbers;

    switch (validatorType) {
      case 0:
        if (start != null && end != null) {
          return value.length >= start! && value.length <= end! ? null : NumberInputError.outRange;
        } else if (start != null) {
          return value.length >= start! ? null : NumberInputError.outRange;
        } else if (end != null) {
          return value.length <= end! ? null : NumberInputError.outRange;
        } else {
          return null;
        }
      case 1:
        if (start != null && end != null) {
          return _tryParse(value)! >= start! && _tryParse(value)! <= end! ? null : NumberInputError.outRange;
        } else if (start != null) {
          return _tryParse(value)! >= start! ? null : NumberInputError.outRange;
        } else if (end != null) {
          return _tryParse(value)! <= end! ? null : NumberInputError.outRange;
        } else {
          return null;
        }
      default:
        return NumberInputError.empty;
    }
  }

  double? _tryParse(value){
    String _try = value;
    while (double.tryParse(_try) == null) {
      _try = _try.substring(0, _try.length-1);
    }
    return double.tryParse(_try);
  }
}