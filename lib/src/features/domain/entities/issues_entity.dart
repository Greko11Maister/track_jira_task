import 'package:equatable/equatable.dart';

class IssuesEntity extends Equatable {
  final int? id;
  final String? name;
  final String? description;

  IssuesEntity({
    this.id,
    this.name,
    this.description
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, description];
}
