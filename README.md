Show và submit leaderboard.

### Cách sử dụng

```
  btnLearboardClick(BuildContext context) async {
    if (await AppUserDataUtils.isNeedSubmitLeadboard()) {
      int totalScore = await AppUserDataUtils.getTotalScore();
      if (totalScore > 0) {
        try {
          await GameServiceManager.submitLeaderboardScore(totalScore,
              android_leaderboard_id: Keys.LEADERBOARD_ID, ios_leaderboard_id: Keys.IOS_LEADERBOARD_ID);
        } catch (err) {
          L.e("submitLeaderboardScore: $err");
        }
      }
    }

    GameServiceManager.showLeaderboard(
        android_leaderboard_id: Keys.LEADERBOARD_ID, ios_leaderboard_id: Keys.IOS_LEADERBOARD_ID);
  }
  
```