import 'package:equatable/equatable.dart';
import 'package:peepl/models/app_state.dart';
import 'package:peepl/redux/actions/swap_actions.dart';
import 'package:peepl/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';
import 'package:peepl/utils/addresses.dart' as util;

class HomeScreenViewModel extends Equatable {
  final bool? isContactsSynced;
  final bool backup;
  final bool isBackupDialogShowed;
  final Function setShowDialog;
  final Function getSwapListBalances;
  final bool isDefaultCommunity;

  HomeScreenViewModel({
    required this.isContactsSynced,
    required this.backup,
    required this.isBackupDialogShowed,
    required this.isDefaultCommunity,
    required this.setShowDialog,
    required this.getSwapListBalances,
  });

  static HomeScreenViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    return HomeScreenViewModel(
      isDefaultCommunity: util.isDefaultCommunity(communityAddress),
      isContactsSynced: store.state.userState.isContactsSynced,
      backup: store.state.userState.backup,
      isBackupDialogShowed: store.state.userState.receiveBackupDialogShowed,
      setShowDialog: () {
        store.dispatch(ReceiveBackupDialogShowed());
      },
      getSwapListBalances: () {
        store.dispatch(fetchSwapBalances());
      },
    );
  }

  @override
  List<Object> get props => [
        isBackupDialogShowed,
        backup,
      ];
}
