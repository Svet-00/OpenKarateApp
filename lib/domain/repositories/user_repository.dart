import '../../core/models/registration_info.dart';
import '../../data/api/request/credentials.dart';
import '../../data/api/request/refresh_token_credentials.dart';
import '../entities/passport.dart';
import '../entities/token_pair.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<List<User>> fetchTrainers();
  Future<Passport> login(Credentials credentials);
  Future<Passport> register(RegistrationInfo registrationInfo);
  Future<TokenPair> refreshTokens(RefreshTokenCredentials credentials);
  Future<User> updateUserProfile(User user);
}
