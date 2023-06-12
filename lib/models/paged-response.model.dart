class PagedResponse<T> {
  List<T>? items;
  int? totalCount;

  PagedResponse.fromJson(Map<String, dynamic> json) {
    totalCount = int.tryParse(json["total"].toString()) ?? 0;
  }
}