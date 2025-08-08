import 'package:shared_preferences/shared_preferences.dart';

class StreakManager {
  static const String _key = 'streak';

  static Future<void> incrementStreak() async {
    final prefs = await SharedPreferences.getInstance();
    int streak = prefs.getInt(_key) ?? 0;
    prefs.setInt(_key, streak + 1);
  }

  static Future<int> getStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_key) ?? 0;
  }
}
