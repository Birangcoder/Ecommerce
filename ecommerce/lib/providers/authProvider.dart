import 'package:ecommerce/models/UserProfile.dart';
import 'package:riverpod/riverpod.dart';
import '../config/secureStorage.dart';
import '../models/login_response.dart';
import '../repositiory/auth_repository.dart';

final authRepoProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

class authNotifier extends AsyncNotifier<UserProfile?> {
  final _secure = SecureStorageService.instance;

  @override
  Future<UserProfile?> build() async {
    final accessToken = await _secure.read('accessToken');
    final refreshToken = await _secure.read('refreshToken');
    if (accessToken == null || refreshToken == null) {
      return null;
    }

    try {
      final repo = ref.read(authRepoProvider);
      return await repo.getCurrentUser(accessToken);
    } catch (e) {
      await _secure.deleteAll();
      return null;
    }
  }

  Future<void> login(String username, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(authRepoProvider);
      final result = await repo.login(username: username, password: password);

      await _secure.write('accessToken', result.accessToken);
      await _secure.write('refreshToken', result.refreshToken);

      return UserProfile(
        id: result.id,
        username: result.username,
        email: result.email,
        firstName: result.firstName,
        lastName: result.lastName,
        image: result.image,
      );
    });
  }

  Future<void> logout() async {
    await _secure.deleteAll();
    state = const AsyncData(null);
  }
}

final authProvider = AsyncNotifierProvider<authNotifier, UserProfile?>(
  authNotifier.new,
);
