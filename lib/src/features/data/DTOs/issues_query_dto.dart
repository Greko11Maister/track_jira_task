class IssuesQueryDTO{
  String? query;
  String? idProject;

  IssuesQueryDTO({this.query, this.idProject});

  Map<String, dynamic>? get queryParameters{
    final Map<String, dynamic> data = <String, dynamic>{};
    data['query'] = query;
    data['currentProjectId'] = idProject;

    return data;
  }
}