import '../entities/gym.dart';
import '../entities/schedule.dart';

abstract class ScheduleRepository {
  Future<List<Schedule>> fetchForGym(
    Gym gym,
  );

  Future<List<Schedule>> fetchAll();
}
