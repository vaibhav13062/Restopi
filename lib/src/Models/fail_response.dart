class FailResponse {
  final int statusCode;
  final dynamic body;
  FailResponse({required this.statusCode, required this.body});
  FailResponse.fromJson(Map<String, dynamic> json)
      : statusCode = json['statusCode'].toInt(),
        body = json['body'];

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'body': body,
      };
}
