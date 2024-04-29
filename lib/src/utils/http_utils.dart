import 'package:dio/dio.dart';
import 'package:soal_natura/src/utils/preferences_utils.dart';

class Http {
  static final Http _httpMod = Http._internal();
  factory Http() {
    return _httpMod;
  }
  Http._internal();

  static const IS_DEV = true;

  // static const String _host = "cosbiome.online";
  static const String _host =
      IS_DEV ? "http://localhost:1337/" : "https://cosbiome.online/";

  static final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  static final Map<String, String> _headersAuth = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${PreferencesUtils.getString("token")}',
  };

  static Future<Response> get(
    String path,
    Map<String, dynamic> parameters,
  ) async {
    Uri url = Uri.parse(
      _host + path,
    ).replace(queryParameters: parameters);

    Response response = await Dio().get(
      url.toString(),
      options: Options(
        headers: _headersAuth,
      ),
    );

    return response;
  }

  static Future<Response> loginSocialNetwork(
    String path,
    Map<String, dynamic> parameters,
  ) async {
    Uri url = Uri.parse(
      _host + path,
    ).replace(queryParameters: parameters);

    Response response = await Dio().get(
      url.toString(),
    );

    return response;
  }

  static Future<Response> post(
    String path,
    String data,
  ) async {
    Uri url = Uri.parse(
      _host + path,
    );
    Response response = await Dio().post(
      url.toString(),
      data: data,
      options: Options(
        headers: _headersAuth,
      ),
    );

    return response;
  }

  static Future<Response> login(
    String path,
    String data,
  ) async {
    Uri url = Uri.parse(
      _host + path,
    );

    Response response = await Dio().post(
      url.toString(),
      data: data,
      options: Options(
        headers: _headers,
      ),
    );

    return response;
  }

  static Future<Response> update(
    String path,
    String data,
  ) async {
    Uri url = Uri.parse(
      _host + path,
    );
    Response response = await Dio().put(
      url.toString(),
      data: data,
      options: Options(
        headers: _headersAuth,
      ),
    );

    return response;
  }

  static Future<Response> delete(
    String path,
    Map<String, dynamic> parameters,
  ) async {
    Uri url = Uri.parse(
      _host + path,
    ).replace(queryParameters: parameters);
    Response response = await Dio().delete(
      url.toString(),
      options: Options(
        headers: _headersAuth,
      ),
    );

    return response;
  }

  static Future<String> uploadFileToS3(FormData data) async {
    String host = 'https://cosbiomeescuela.s3.us-east-2.amazonaws.com/';

    await Dio().post(
      host,
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    return host + data.fields.first.value;
  }
}
