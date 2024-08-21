import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/song.dart';

class MusicService {
  final String apiUrl = 'https://itunes.apple.com';

  Future<List<Song>> searchSongs(String query) async {
    try {
      final encodedQuery = Uri.encodeQueryComponent(query);
      final response = await http.get(Uri.parse('$apiUrl/search?term=$encodedQuery&media=music'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] == null) {
          throw Exception('No results field in response');
        }
        final List songs = data['results'];
        return songs.map((song) => Song.fromJson(song)).toList();
      } else {
        throw Exception('Failed to search songs: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
