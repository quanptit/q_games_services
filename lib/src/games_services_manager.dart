// ignore_for_file: non_constant_identifier_names

import 'package:common_utils/l.dart';
import 'package:games_services/games_services.dart';
import 'package:common_utils/common_utils.dart';

class GameServiceManager {
  static Future<bool> signIn() async {
    try {
      // var result = await GameAuth.signIn(shouldEnableSavedGame: false);
      var result = await GamesServices.signIn();
      // final signedIn = await GamesServices.isSignedIn;
      L.d("signIn result: $result");
      return true;
    } catch (err) {
      L.e("signIn Error log: $err");
      return false;
    }
  }

  static Future<bool> isSignedIn() {
    return GameAuth.isSignedIn;
  }

  /// Launches the platform's UI overlay with leaderboard(s).
  static Future<void> showLeaderboard({String? ios_leaderboard_id, String? android_leaderboard_id}) async {
    L.d('Show leaderboard android_leaderboard_id: $android_leaderboard_id');
    try {
      if (!await isSignedIn()) {
        await signIn();
      }
    } catch (err) {
      L.e("SignedIn ERROR: $err");
    }

    try {
      await Leaderboards.showLeaderboards(iOSLeaderboardID: ios_leaderboard_id, androidLeaderboardID: android_leaderboard_id);
    } catch (e) {
      L.d('Cannot show leaderboard: $e');
    }
  }

  /// Submits [score] to the leaderboard.
  static Future<void> submitLeaderboardScore(int? value, {String? ios_leaderboard_id, String? android_leaderboard_id}) async {
    assert(CommonUtils.isIOS() ? ios_leaderboard_id != null : android_leaderboard_id != null);
    L.d('Submitting $value to leaderboard: ${ios_leaderboard_id ?? android_leaderboard_id}');
    try {
      if (!await isSignedIn()) {
        await signIn();
      }
    } catch (err) {
      L.e("SignedIn ERROR: $err");
    }

    try {
      await Leaderboards.submitScore(
          score: Score(androidLeaderboardID: android_leaderboard_id, iOSLeaderboardID: ios_leaderboard_id, value: value));
    } catch (e) {
      L.d('Cannot submit leaderboard score: $e');
    }
  }
}
