class PagedResponse<T> {
  List<T>? items;
  int totalCount = 0;

  PagedResponse.fromJson(Map<String, dynamic> json) {
    totalCount = int.tryParse(json["total"]) ?? 50;
  }
}