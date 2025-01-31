import 'dart:convert';

import 'package:mixin_bot_sdk_dart/mixin_bot_sdk_dart.dart';
import 'package:test/scaffolding.dart';

import 'config.dart';

void main() {
  final client = Client(
    userId: uid,
    sessionId: sid,
    sessionPrivateKey: private,
  );
  test('test getAllSnapshots', () async {
    try {
      final resp = await client.tokenApi.getAllSnapshots();
      // ignore: avoid_print
      print(jsonEncode(resp.data));
    } catch (e) {
      if (e is MixinApiError) {
        // ignore: avoid_print
        print(e.error);
      }
    }
  });
}
