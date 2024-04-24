import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../core/global/global.dart';

class AdSpaceDialog extends StatelessWidget {
  const AdSpaceDialog({super.key});


  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;

    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: InkWell(
        onTap: () {
          player.setAudioSource(AudioSource.asset('assets/audio/click.mp3'))
              .then((value) => player.play().then((value) => Navigator.pop(context)));
        },
        child: SizedBox(
          height: size.height * 0.36,
          width: size.width,
          child: Image.asset('assets/images/ads.png',
            width: size.width, fit: BoxFit.fill,
            opacity: const AlwaysStoppedAnimation(.85),
          ),
        ),
      ),
    );
  }
}