class Messages {
  late String msg;

  Messages({
    required this.msg,
  });

  Messages.fromJson(Map<String, dynamic> json) {
    msg = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = msg;
    return data;
  }
}
