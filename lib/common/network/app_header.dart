class AppHeader {
  String accessToken;

  AppHeader({this.accessToken});

  AppHeader.fromJson(Map<String, dynamic> json) {
    accessToken = json['Authorization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (accessToken != null) {
      data['Authorization'] = 'Bearer $accessToken';
    }
    return data;
  }
}
