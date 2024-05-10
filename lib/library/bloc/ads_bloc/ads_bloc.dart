import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:library_treasure_hunt/library/bloc/ads_bloc/ads_states.dart';
import 'package:library_treasure_hunt/library/bloc/values/values_bloc.dart';
import 'package:library_treasure_hunt/library/core/global/global.dart';

class AdsBloc extends Cubit<AdsStates> {
  AdsBloc() : super(AdsInitialState());

  static AdsBloc get(context) => BlocProvider.of(context);

  RewardedAd? rewardedAd;
  int rewardScore = 0;

  loadRewardAds() {
    emit(AdsLoadingState());
    RewardedAd.load(
      adUnitId: 'ca-app-pub-5638922691618476/9327199178',
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          rewardedAd = ad;
          printWithColorAndStyle(
            'Ads loaded success',
          );
          showAds();
          emit(AdsSuccessState());
        },
        onAdFailedToLoad: (error) {
          rewardedAd = null;
          printWithColorAndStyle(
            'Ads faild to load try agian later',
          );
          emit(AdsErrorState());
        },
      ),
    );
  }

  Future<bool> showAds() async {
    if (rewardedAd != null) {
      rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          rewardedAd!.dispose();
          //loadRewardAds();
          emit(AdsSuccessState());
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          rewardedAd!.dispose();
          //loadRewardAds();
          emit(AdsErrorState());
        },
      );
      try {
        await rewardedAd!.show(
          onUserEarnedReward: ((ad, reward) {
            rewardScore++;
            emit(AdsChangeScoreState());
            printWithColorAndStyle(
              'Reward: $rewardScore',
            );
            if (heartCount! < 5) {
              valuesBloc.add(AddHeartCountEvent());
            }
          }),
        );
        return true; // Ad successfully shown
      } catch (e) {
        printWithColorAndStyle(
          'failed to show ad',
        );
        return false; // Ad failed to show
      }
    }
    return false; // Ad is not loaded
  }

  // Helper method to print text with custom color and style
  void printWithColorAndStyle(String text) {
    debugPrint('\x1B[33m$text\x1B[0m');
  }

  //loading
  bool isLoading = false;
  void changeLoadingState() {
    isLoading = !isLoading;
    printWithColorAndStyle(isLoading.toString());
    emit(AdsChangeLoadingState());
  }
}