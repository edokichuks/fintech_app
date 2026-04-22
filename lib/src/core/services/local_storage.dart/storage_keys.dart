///USE AN ENUM TO ALLOW DEVS KEEP TRACK OF ALL THE
///AVAILABLE STORED PROPERTIES AND KEY NAMES
enum LocalStoreKeysManger {
  appBox('appBox'),
  password('password'),
  token('token'),
  user('user'),
  userPin('userPin'),
  currentState('current_state'),
  refreshToken('refresh_token'),
  rememberMe('rememberMe'),
  sessionToken("session_token"),
  userLastPositon("last_location.dart"),
  userAddress('user_address'),
  addresses('addresses'),
  fcmToken('fcmToken'),
  hasSavedFcmTokenRemotely('hasSavedFcmTokenRemotely'),
  display('display'),
  balanceVisibility('balanceVisibility'),
  deviceToken('device_token'),
  hasRatedApp('hasRatedApp'),
  lastRatedDate('lastRatedDate'),
  transactionCountSinceRating('transactionCountSinceRating');
  
  final String rawValue;
  const LocalStoreKeysManger(this.rawValue);
}
