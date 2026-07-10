import 'package:riverpod/riverpod.dart';
import '../models/login_response.dart';
import '../repositiory/auth_repository.dart';

final authRepoProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

class authNotifier extends AsyncNotifier<LoginResponse?>{

  @override
  Future<LoginResponse?> build() async => null;

  Future<void> login(String username, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(authRepoProvider);
      return repo.login(username: username, password: password);
    });
  }

  void logout(){
    state = const AsyncData(null);
  }
}

final authProvider = AsyncNotifierProvider<authNotifier, LoginResponse?>(authNotifier.new);