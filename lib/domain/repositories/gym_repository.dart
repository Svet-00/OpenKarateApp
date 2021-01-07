import '../entities/gym.dart';

abstract class GymRepository {
  Future<List<Gym>> fetchAll();
  Future<void> addToFavorites(String id);
  Future<void> removeFromFavorites(String id);
}
