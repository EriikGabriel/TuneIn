import 'dart:convert';
import 'dart:math';

import "package:http/http.dart" as http;

class SpotifyModel {
  final String _clientId = 'a914f36327044a0abea8daf592f58ac2';
  final String _clientSecret = 'a0f8fe046c074c06aeee837cb31f2604';
  String? _accessToken;

  Future<void> _authenticate() async {
    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$_clientId:$_clientSecret'))}',
      },
      body: {'grant_type': 'client_credentials'},
    );

    if (response.statusCode == 200) {
      _accessToken = jsonDecode(response.body)['access_token'];
    } else {
      throw Exception('Authentication with Spotify failed!');
    }
  }

  Future<List<Map<String, String>>> _search(String query, String type) async {
    if (_accessToken == null) {
      await _authenticate();
    }

    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/search?q=$query&type=$type'),
      headers: {'Authorization': 'Bearer $_accessToken'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<dynamic> items = data['${type}s']['items'];

      return items.map<Map<String, String>>((item) {
        return {
          'artist': item['artists'][0]['name'],
          'name': item['name'],
          'imageUrl': item['album']['images'][0]['url'],
        };
      }).toList();
    } else {
      throw Exception('Error fetching songs from Spotify API');
    }
  }

  Future<List<Map<String, String>>> searchTracks(String query) async {
    return await _search(query, 'track');
  }

  Future<List<Map<String, String>>> searchTracksByGenre(String genre) async {
    return await _search('genre:$genre', 'track');
  }

  Future<List<Map<String, String>>> getRecommendations() async {
    if (_accessToken == null) {
      await _authenticate();
    }

    final random = Random();
    final searchQueries = [
      "rock",
      "pop",
      "jazz",
      "lofi",
      "classical",
      "chill",
      "hip-hop",
      "edm",
      "alternative",
      "acoustic",
      "indie",
      "blues",
      "metal",
      "reggae",
    ];

    final selectedQuery = searchQueries[random.nextInt(searchQueries.length)];

    final response = await http.get(
      Uri.parse(
        'https://api.spotify.com/v1/search?q=$selectedQuery&type=track&limit=10',
      ),
      headers: {'Authorization': 'Bearer $_accessToken'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<dynamic> tracks = data['tracks']['items'];

      return tracks.map<Map<String, String>>((track) {
        return {
          'artist': track['artists'][0]['name'],
          'name': track['name'],
          'imageUrl':
              track['album']['images'].isNotEmpty
                  ? track['album']['images'][0]['url']
                  : '',
        };
      }).toList();
    } else {
      throw Exception('Error fetching recommendations from Spotify API');
    }
  }
}
