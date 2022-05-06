class ProjectDTO{
  String? id;

  ProjectDTO({this.id});

  Map<String, dynamic>? get queryParameters{
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentProjectId'] = id;
    data["showSubTasks"] = true;

    return data;
}
}