import 'package:dio/dio.dart';

import '../../mixin_bot_sdk_dart.dart';

class ConversationApi {
  ConversationApi({required this.dio});

  final Dio dio;

  Future<MixinResponse<ConversationResponse>> createConversation(
          ConversationRequest request) =>
      MixinResponse.request<ConversationResponse>(
        dio.post('/conversations', data: request),
        ConversationResponse.fromJson,
      );

  Future<MixinResponse<ConversationResponse>> update(
          String conversationId, ConversationRequest request) =>
      MixinResponse.request<ConversationResponse>(
        dio.post('/conversations/${Uri.encodeComponent(conversationId)}',
            data: request),
        ConversationResponse.fromJson,
      );

  Future<MixinResponse<void>> exit(String conversationId) =>
      MixinResponse.requestVoid(dio
          .post('/conversations/${Uri.encodeComponent(conversationId)}/exit'));

  Future<MixinResponse<ConversationResponse>> getConversation(String id) =>
      MixinResponse.request<ConversationResponse>(
        dio.get('/conversations/${Uri.encodeComponent(id)}'),
        ConversationResponse.fromJson,
      );

  Future<MixinResponse<ConversationResponse>> updateConversation(String id) =>
      MixinResponse.request<ConversationResponse>(
        dio.get('/conversations/${Uri.encodeComponent(id)}'),
        ConversationResponse.fromJson,
      );

  Future<MixinResponse<ConversationResponse>> participants(
          String id, String action, List<ParticipantRequest> requests) =>
      MixinResponse.request<ConversationResponse>(
        dio.post(
            '/conversations/${Uri.encodeComponent(id)}/participants/${Uri.encodeComponent(action)}',
            data: requests),
        ConversationResponse.fromJson,
      );

  Future<MixinResponse<ConversationResponse>> mute(
          String id, ConversationRequest request) =>
      MixinResponse.request<ConversationResponse>(
        dio.post('/conversations/${Uri.encodeComponent(id)}/mute',
            data: request),
        ConversationResponse.fromJson,
      );

  Future<MixinResponse<ConversationResponse>> rotate(String id) =>
      MixinResponse.request<ConversationResponse>(
        dio.post('/conversations/${Uri.encodeComponent(id)}/rotate'),
        ConversationResponse.fromJson,
      );

  Future<MixinResponse<ConversationResponse>> join(String id) =>
      MixinResponse.request(
        dio.post('/conversations/${Uri.encodeComponent(id)}/join'),
        ConversationResponse.fromJson,
      );

  Future<MixinResponse<ConversationResponse>> disappear(
          String id, DisappearRequest request) =>
      MixinResponse.request<ConversationResponse>(
        dio.post('/conversations/${Uri.encodeComponent(id)}/disappear',
            data: request),
        ConversationResponse.fromJson,
      );
}
