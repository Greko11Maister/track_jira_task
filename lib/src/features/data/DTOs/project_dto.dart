class ProjectDTO{
  String? id;

  ProjectDTO({this.id});

  Map<String, dynamic>? get queryParameters{
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentProjectId'] = this.id;

    return data;
}
}