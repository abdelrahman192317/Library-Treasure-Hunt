import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/ads_bloc/ads_bloc.dart';
import '../../bloc/ads_bloc/ads_states.dart';
import '../../core/utilities/functions.dart';


class AdsButton extends StatefulWidget {
  const AdsButton({super.key, required this.answer});
  final String answer;

  @override
  State<AdsButton> createState() => _AdsButtonState();
}

class _AdsButtonState extends State<AdsButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.01),
      child: BlocConsumer<AdsBloc, AdsStates>(
        listener: (context, state) {
          if (state is AdsLoadingState) {
            Helper.toast(context, 'سوف يتم تشغيل الإعلان برجاء الانتظار');
          }
        },
        builder: (context, state) {
          // Check the current state to determine which UI to display
          if (state is AdsLoadingState) {
            // Display loading indicator while loading ads
            return buildLoadingButton(size);
          } else if (state is AdsErrorState) {
            // Display an error message if ads fail to load
            return buildErrorButton(size, context);
          } else {
            // Ads are loaded or successfully shown, display the button with ad content
            return buildContentButton(size, context, context, widget.answer);
          }
        },
      ),
    );
  }
}

Widget buildLoadingButton(Size size) {
  return SizedBox(
    width: size.width,
    height: size.height * 0.08,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
      onPressed: () {}, // Disable button while loading
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    ),
  );
}

Widget buildErrorButton(Size size, context) {
  return SizedBox(
    width: size.width,
    height: size.height * 0.08,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
      onPressed: () {
        // Reload ads when the button is clicked again after an error
        AdsBloc.get(context).loadRewardAds();
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, color: Colors.white),
          Text(
            'Error Loading Ads, Tap to Retry',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    ),
  );
}

Widget buildContentButton(Size size, BuildContext con, context, answer) {
  return SizedBox(
    width: size.width,
    height: size.height * 0.08,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
      onPressed: () async {
        // Show ads when the button is clicked
        AdsBloc.get(context).loadRewardAds();
        await AdsBloc.get(context).showAds();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/reward.png',
            height: size.height * 0.03,
          ),
          Padding(
            padding: EdgeInsets.only(right: size.height * 0.02),
            child: Text(
              answer,
              style: con.getThemeTextStyle().titleLarge!.copyWith(fontSize: 20),
            ),
          ),
        ],
      ),
    ),
  );
}
