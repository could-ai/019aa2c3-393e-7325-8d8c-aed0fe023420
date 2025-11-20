import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../models/song.dart';

class AudioProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  List<Song> _playlist = [];
  int _currentIndex = -1;
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  // Mock Data for Demo
  AudioProvider() {
    _playlist = [
      Song(
        id: '1',
        title: 'Savage Mode',
        artist: 'Future Bass',
        albumArtUrl: 'https://images.unsplash.com/photo-1493225255756-d9584f8606e9?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
        audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
        duration: '6:12',
      ),
      Song(
        id: '2',
        title: 'Night Vibes',
        artist: 'Neon Dreams',
        albumArtUrl: 'https://images.unsplash.com/photo-1614613535308-eb5fbd3d2c17?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
        audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
        duration: '7:05',
      ),
      Song(
        id: '3',
        title: 'Cyber Punk',
        artist: 'Synthwave',
        albumArtUrl: 'https://images.unsplash.com/photo-1619983081563-430f63602796?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
        audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
        duration: '5:44',
      ),
       Song(
        id: '4',
        title: 'Deep Ocean',
        artist: 'Blue Waves',
        albumArtUrl: 'https://images.unsplash.com/photo-1468164016595-6108e4c60c8b?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
        audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
        duration: '5:02',
      ),
    ];

    _audioPlayer.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      notifyListeners();
    });

    _audioPlayer.positionStream.listen((pos) {
      _position = pos;
      notifyListeners();
    });

    _audioPlayer.durationStream.listen((dur) {
      _duration = dur ?? Duration.zero;
      notifyListeners();
    });
  }

  List<Song> get playlist => _playlist;
  Song? get currentSong => _currentIndex != -1 ? _playlist[_currentIndex] : null;
  bool get isPlaying => _isPlaying;
  Duration get position => _position;
  Duration get duration => _duration;

  Future<void> playSong(Song song) async {
    final index = _playlist.indexOf(song);
    if (index == -1) return;

    if (_currentIndex == index && _audioPlayer.playing) {
      pause();
      return;
    }

    _currentIndex = index;
    try {
      await _audioPlayer.setUrl(song.audioUrl);
      _audioPlayer.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
    notifyListeners();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void resume() {
    _audioPlayer.play();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void next() {
    if (_currentIndex < _playlist.length - 1) {
      playSong(_playlist[_currentIndex + 1]);
    }
  }

  void previous() {
    if (_currentIndex > 0) {
      playSong(_playlist[_currentIndex - 1]);
    }
  }
}
