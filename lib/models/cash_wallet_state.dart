import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:peepl/constants/addresses.dart';
import 'package:peepl/models/actions/actions.dart';
import 'package:peepl/models/actions/wallet_action.dart';
import 'package:peepl/models/community/community.dart';
import 'package:peepl/models/tokens/token.dart';
import 'package:peepl/utils/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cash_wallet_state.freezed.dart';
part 'cash_wallet_state.g.dart';

WalletActions walletActionsFromJson(Map<String, dynamic>? walletActions) =>
    walletActions == null
        ? WalletActions.initial()
        : WalletActions.fromJson(walletActions);

Map<String, Token> tokensFromJson(Map<String, dynamic>? tokens) =>
    tokens == null
        ? Map<String, Token>()
        : tokens.map(
            (k, e) => MapEntry(
              k,
              Token.fromJson(
                e as Map<String, dynamic>,
              ),
            ),
          )
      ..putIfAbsent(
        Addresses.PPL_TOKEN_ADDRESS,
        () => PeeplToken.copyWith(),
      )
      ..putIfAbsent(
        Addresses.GBPX_TOKEN_ADDRESS,
        () => GBPxToken.copyWith(),
      );

Map<String, Community> communitiesFromJson(Map<String, dynamic>? list) {
  if (list == null) {
    return Map<String, Community>();
  } else if (list.containsKey('communities')) {
    Map<String, Community> communities = Map<String, Community>();
    Iterable<MapEntry<String, Community>> entries =
        List.from(list['communities']).map((community) => MapEntry(
            (community['address'] as String).toLowerCase(),
            Community.fromJson(community)));
    communities.addEntries(entries);
    return communities;
  } else {
    return list.map(
      (k, e) => MapEntry(k, Community.fromJson(e as Map<String, dynamic>)),
    );
  }
}

@immutable
@freezed
class CashWalletState with _$CashWalletState {
  const CashWalletState._();

  @JsonSerializable()
  factory CashWalletState({
    @Default('') String communityAddress,
    @Default(true) bool isDepositBanner,
    @JsonKey(fromJson: tokensFromJson) @Default({}) Map<String, Token> tokens,
    @JsonKey(fromJson: communitiesFromJson)
    @Default({})
        Map<String, Community> communities,
    @JsonKey(fromJson: walletActionsFromJson) WalletActions? walletActions,
    @JsonKey(ignore: true) @Default(false) bool isCommunityLoading,
    @JsonKey(ignore: true) @Default(false) bool isCommunityFetched,
    @JsonKey(ignore: true) @Default(false) bool isTransfersFetchingStarted,
    @JsonKey(ignore: true) @Default(false) bool isCommunityBusinessesFetched,
    @JsonKey(ignore: true) @Default(false) bool isFetchingBalances,
  }) = _CashWalletState;

  factory CashWalletState.initial() {
    return CashWalletState(
      communities: Map<String, Community>(),
      tokens: Map<String, Token>()
        ..putIfAbsent(
          Addresses.PPL_TOKEN_ADDRESS,
          () => PeeplToken.copyWith(),
        )
        ..putIfAbsent(
          Addresses.GBPX_TOKEN_ADDRESS,
          () => GBPxToken.copyWith(),
        ),
      walletActions: WalletActions().copyWith(
        list: <WalletAction>[],
        updatedAt: 0,
      ),
    );
  }

  factory CashWalletState.fromJson(dynamic json) =>
      _$CashWalletStateFromJson(json);
}

class CashWalletStateConverter
    implements JsonConverter<CashWalletState, Map<String, dynamic>?> {
  const CashWalletStateConverter();

  @override
  CashWalletState fromJson(Map<String, dynamic>? json) =>
      json != null ? CashWalletState.fromJson(json) : CashWalletState.initial();

  @override
  Map<String, dynamic> toJson(CashWalletState instance) => instance.toJson();
}
