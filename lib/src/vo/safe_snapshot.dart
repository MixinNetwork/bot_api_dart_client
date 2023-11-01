import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'safe_snapshot.g.dart';

@JsonSerializable()
class SafeSnapshot with EquatableMixin {
  SafeSnapshot({
    required this.snapshotId,
    required this.type,
    required this.assetId,
    required this.amount,
    required this.userId,
    required this.opponentId,
    required this.memo,
    required this.transactionHash,
    required this.createdAt,
    required this.traceId,
    required this.confirmations,
    required this.openingBalance,
    required this.closingBalance,
  });

  factory SafeSnapshot.fromJson(Map<String, dynamic> json) =>
      _$SafeSnapshotFromJson(json);

  @JsonKey(name: 'snapshot_id')
  final String snapshotId;
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'asset_id')
  final String assetId;
  @JsonKey(name: 'amount')
  final String amount;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'opponent_id')
  final String opponentId;
  @JsonKey(name: 'memo')
  final String memo;
  @JsonKey(name: 'transaction_hash')
  final String transactionHash;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'trace_id')
  final String? traceId;
  @JsonKey(name: 'confirmations')
  final int? confirmations;
  @JsonKey(name: 'opening_balance')
  final String? openingBalance;
  @JsonKey(name: 'closing_balance')
  final String? closingBalance;

  Map<String, dynamic> toJson() => _$SafeSnapshotToJson(this);

  @override
  List<Object?> get props => [
        snapshotId,
        type,
        assetId,
        amount,
        userId,
        opponentId,
        memo,
        transactionHash,
        createdAt,
        traceId,
        confirmations,
        openingBalance,
        closingBalance,
      ];
}
