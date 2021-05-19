import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mixin_bot_sdk_dart/src/api/attachment_api.dart';
import 'package:mixin_bot_sdk_dart/src/api/circle_api.dart';
import 'package:mixin_bot_sdk_dart/src/api/conversation_api.dart';

import '../mixin_bot_sdk_dart.dart';
import 'api/account_api.dart';
import 'api/circle_api.dart';
import 'api/message_api.dart';
import 'api/provisioning_api.dart';
import 'api/user_api.dart';
import 'auth.dart';
import 'error/mixin_api_error.dart';
import 'log_interceptor.dart';

const mixinBaseUrl0 = 'https://api.mixin.one';
const mixinBaseUrl1 = 'https://mixin-api.zeromesh.net';

class Client {
  Client({
    String? userId,
    String? sessionId,
    String? privateKey,
    String? scp,
    String? baseUrl,
    BaseOptions? dioOptions,
    JsonDecodeCallback? jsonDecodeCallback,
    Iterable<Interceptor> interceptors = const [],
    HttpLogLevel? httpLogLevel = HttpLogLevel.all,
  }) {
    _dio = Dio(dioOptions);
    _dio.options.baseUrl = baseUrl ?? mixinBaseUrl0;
    _dio.options.responseType = ResponseType.json;
    (dio.transformer as DefaultTransformer).jsonDecodeCallback =
        jsonDecodeCallback;
    _dio.interceptors.addAll(interceptors);
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (
        RequestOptions options,
        RequestInterceptorHandler handler,
      ) async {
        var body = '';
        if (options.data != null) {
          body = jsonEncode(options.data);
        }
        options.headers['Accept-Language'] ??= 'en_US';
        options.headers['Authorization'] = 'Bearer ' +
            signAuthTokenWithEdDSA(
              userId,
              sessionId,
              privateKey,
              scp,
              options.method,
              options.path,
              body,
            );
        handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        var error = response.data['error'];
        if (error == null) return handler.next(response);

        return handler.reject(
          MixinApiError(
            requestOptions: response.requestOptions,
            response: response,
            error: MixinError.fromJson(error),
          ),
          true,
        );
      },
      onError: (DioError e, ErrorInterceptorHandler handler) async {
        if ((e is MixinApiError && e.error.code < 500)) {
          return handler.next(e);
        }

        dio.options.baseUrl =
            dio.options.baseUrl == mixinBaseUrl0 ? mixinBaseUrl1 : mixinBaseUrl0;

        try {
          var response = await dio.request(
            e.requestOptions.path,
            data: e.requestOptions.data,
            queryParameters: e.requestOptions.queryParameters,
            cancelToken: e.requestOptions.cancelToken,
            options: Options(
              method: e.requestOptions.method,
              headers: e.requestOptions.headers,
              responseType: e.requestOptions.responseType,
              contentType: e.requestOptions.contentType,
            ),
            onSendProgress: e.requestOptions.onSendProgress,
            onReceiveProgress: e.requestOptions.onReceiveProgress,
          );
          return handler.resolve(response);
        } catch (error) {
          return handler.reject(error is DioError ? error : e);
        }
      },
    ));
    if (httpLogLevel != null) {
      _dio.interceptors.add(MixinLogInterceptor(httpLogLevel));
    }
    _userApi = UserApi(dio: _dio);
    _provisioningApi = ProvisioningApi(dio: _dio);
    _accountApi = AccountApi(dio: _dio);
    _conversationApi = ConversationApi(dio: _dio);
    _messageApi = MessageApi(dio: _dio);
    _attachmentApi = AttachmentApi(dio: _dio);
    _circleApi = CircleApi(dio: _dio);
  }

  late Dio _dio;
  late ProvisioningApi _provisioningApi;
  late UserApi _userApi;
  late ConversationApi _conversationApi;
  late MessageApi _messageApi;
  late AccountApi _accountApi;
  late AttachmentApi _attachmentApi;
  late CircleApi _circleApi;

  Dio get dio => _dio;

  AccountApi get accountApi => _accountApi;

  ConversationApi get conversationApi => _conversationApi;

  MessageApi get messageApi => _messageApi;

  UserApi get userApi => _userApi;

  ProvisioningApi get provisioningApi => _provisioningApi;

  AttachmentApi get attachmentApi => _attachmentApi;

  CircleApi get circleApi => _circleApi;
}
