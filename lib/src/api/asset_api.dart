import 'package:dio/dio.dart';

import '../../mixin_bot_sdk_dart.dart';

class AssetApi {
  AssetApi({required this.dio});

  final Dio dio;

  Future<MixinResponse<List<Asset>>> getAssets() => MixinResponse.requestList(
        dio.get('/assets'),
        Asset.fromJson,
      );

  Future<MixinResponse<Asset>> getAssetById(String id) =>
      MixinResponse.request<Asset>(
        dio.get('/assets/${Uri.encodeComponent(id)}'),
        Asset.fromJson,
      );

  Future<MixinResponse<AssetFee>> getAssetFee(String id) =>
      MixinResponse.request<AssetFee>(
        dio.get('/assets/${Uri.encodeComponent(id)}/fee'),
        AssetFee.fromJson,
      );

  Future<MixinResponse<List<Token>>> queryAsset(String query) =>
      MixinResponse.requestList(
        dio.get('/network/assets/search/${Uri.encodeComponent(query)}'),
        Token.fromJson,
      );

  Future<MixinResponse<List<PendingDeposit>>> pendingDeposits(
    String? assetId, {
    String? destination,
    String? tag,
  }) =>
      MixinResponse.requestList(
        dio.get('/external/transactions', queryParameters: <String, dynamic>{
          if (assetId != null && assetId.isNotEmpty) 'asset': assetId,
          if (destination != null && destination.isNotEmpty)
            'destination': destination,
          if (tag != null && tag.isNotEmpty) 'tag': tag,
        }),
        PendingDeposit.fromJson,
      );

  Future<MixinResponse<List<Asset>>> getTopAssets() =>
      MixinResponse.requestList(
        dio.get('/network/assets/top'),
        Asset.fromJson,
      );

  Future<MixinResponse<List<Chain>>> getChains() => MixinResponse.requestList(
        dio.get('/network/chains'),
        Chain.fromJson,
      );

  Future<MixinResponse<Chain>> getChain(String chainId) =>
      MixinResponse.request<Chain>(
        dio.get('/network/chains/${Uri.encodeComponent(chainId)}'),
        Chain.fromJson,
      );
}
