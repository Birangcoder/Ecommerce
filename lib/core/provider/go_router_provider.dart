import 'package:riverpod/riverpod.dart';
import 'package:flutter/foundation.dart';

import '../../features/auth/presentation/provider/auth_provider.dart';

class GoRouterRefreshNotifier extends ChangeNotifier {
  GoRouterRefreshNotifier(Ref ref) {
    ref.listen(authProvider, (_, __) => notifyListeners());
  }
}

final goRouterRefreshProvider = Provider<GoRouterRefreshNotifier>((ref) {
  return GoRouterRefreshNotifier(ref);
});
