import 'package:equatable/equatable.dart';

class IssuesEntity extends Equatable {
  final int? id;
  final String? name;
  final String? img;
  final String? description;

  IssuesEntity({
    this.id,
    this.name,
    this.img,
    this.description
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, img, description];
}
