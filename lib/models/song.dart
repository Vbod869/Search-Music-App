class Song {
  final String title;
  final String artist;
  final String albumCover;
  final String previewUrl;

  Song({
    required this.title,
    required this.artist,
    required this.albumCover,
    required this.previewUrl,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      title: json['trackName'],
      artist: json['artistName'],
      albumCover: json['artworkUrl100'],
      previewUrl: json['previewUrl'] ?? '',
    );
  }
}
