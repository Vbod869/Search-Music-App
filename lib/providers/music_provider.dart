import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/services/music_service.dart';
import '../models/song.dart';

class MusicProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<Song> songs = [];
  Song? currentSong;
  bool isPlaying = false;
  bool isSearching = false;

  Future<void> searchSongs(String query) async {
    isSearching = true;
    notifyListeners();

    try {
      final musicService = MusicService();
      songs = await musicService.searchSongs(query);
    } catch (e) {
      print('Error fetching songs: $e');
    } finally {
      isSearching = false;
      notifyListeners();
    }
  }

  Future<void> playSong(Song song) async {
    if (currentSong == song && isPlaying) return; // If already playing the same song, do nothing

    try {
      await _audioPlayer.setUrl(song.previewUrl);
      await _audioPlayer.play();
      currentSong = song;
      isPlaying = true;
      notifyListeners();
    } catch (e) {
      // Handle error
      print("Error playing song: $e");
    }
  }

  void stopSong() {
    if (!isPlaying) return; // If not playing, do nothing

    _audioPlayer.stop();
    currentSong = null;
    isPlaying = false;
    notifyListeners();
  }
}
