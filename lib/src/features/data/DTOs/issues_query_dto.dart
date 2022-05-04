class IssuesQueryDTO{
  String? query;

  IssuesQueryDTO({this.query});

  Map<String, dynamic>? get queryParameters{
    final Map<String, dynamic> data = <String, dynamic>{};
    data['query'] = query;

    return data;
  }
}