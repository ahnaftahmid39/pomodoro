import 'package:just_audio/just_audio.dart';

class Sound {
  late final AudioPlayer _player;

  Sound() {
    _player = AudioPlayer();
  }

  void dispose() {
    _player.dispose();
  }

  void playPositive() {
    _player.setAsset('assets/audio/positive.wav');
    _player.play();
  }

  void playNegative() {
    _player.setAsset('assets/audio/negative.wav');
    _player.play();
  }

  void playBeep() {
    _player.setAsset('assets/audio/neutral.mp3');
    _player.play();
  }
}
