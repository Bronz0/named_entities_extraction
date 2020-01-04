import 'dart:convert';

import 'package:http/http.dart';

class RemoteDataSource {
  final url = 'http://10.0.2.2:5000/hello';

  Future<dynamic> getDataFromRemote() async {
    // Response response = await post(
    //   url,
    //   headers: {"Content-Type": "application/json"},
    //   body: json.encode({
    //     "Function": "taggText",
    //     "Text": "السلام عليكم",
    //   }),
    // );
    Response response = await get(url);
    print(response.body);
    return response;
  }
}
