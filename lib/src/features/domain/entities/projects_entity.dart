import 'package:equatable/equatable.dart';

class ProjectsEntity extends Equatable{
  final String? id;
  final String? name;
  final AvatarsUrlsEntity? avatarUrls;

  const ProjectsEntity({
     this.id,
     this.name,
     this.avatarUrls
  });

  @override
  List<Object?> get props => [id, name, avatarUrls];

}

class AvatarsUrlsEntity extends Equatable {
  final String? avatar24;

  const AvatarsUrlsEntity({this.avatar24});

  @override
  List<Object?> get props {
    return [avatar24];
  }
}