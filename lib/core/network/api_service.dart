import '../error/exceptios.dart';
import 'dio_client.dart';
import 'package:dio/dio.dart';

class ApiService {
  final DioClient dioClient = DioClient();

  // GET request
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final headers = await dioClient.getHeaders();
      final response = await dioClient.dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioError catch (e) {
      ApiException.handle(e);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  // POST request
  Future<dynamic> post(String path, {Map<String, dynamic>? body}) async {
    try {
      final headers = await dioClient.getHeaders();
      final response = await dioClient.dio.post(
        path,
        data: body,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioError catch (e) {
      ApiException.handle(e);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  // PUT request
  Future<dynamic> put(String path, {Map<String, dynamic>? body}) async {
    try {
      final headers = await dioClient.getHeaders();
      final response = await dioClient.dio.put(
        path,
        data: body,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioError catch (e) {
      ApiException.handle(e);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  // PATCH request
  Future<dynamic> patch(String path, {Map<String, dynamic>? body}) async {
    try {
      final headers = await dioClient.getHeaders();
      final response = await dioClient.dio.patch(
        path,
        data: body,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioError catch (e) {
      ApiException.handle(e);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  // DELETE request
  Future<dynamic> delete(String path, {Map<String, dynamic>? body}) async {
    try {
      final headers = await dioClient.getHeaders();
      final response = await dioClient.dio.delete(
        path,
        data: body,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioError catch (e) {
      ApiException.handle(e);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }
}
