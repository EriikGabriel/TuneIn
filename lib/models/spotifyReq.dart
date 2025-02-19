import 'dart:convert';
import 'package:http/http.dart' as http;

class Spotifyreq {
  final String _clientId = 'a914f36327044a0abea8daf592f58ac2';
  final String _clientSecret = 'a0f8fe046c074c06aeee837cb31f2604';

  String? _accessToken;

  Future<void> _authenticate() async {
    var response = await http.post(Uri.parse('https://accounts.spotify.com/api/token'),
                headers: {
                  'Content-Type': 'application/x-www-form-urlencoded',
                  'Authorization': 'Basic ${base64Encode(utf8.encode('$_clientId:$_clientSecret'))}',
                },
                body: {'grant_type': 'client_credentials',
                       'client_id': _clientId,
                       'client_secret': _clientSecret,
                      }, 
              );
    
    if (response.statusCode == 200){
      _accessToken = jsonDecode(response.body)['access_token'];
    }
    else {
      throw Exception('Não foi possivel autenticar com Spotify!');
    }
  }



  Future<List<dynamic>> searchTracks(String query) async {
    if (_accessToken == null) {
      await _authenticate();
    }

    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/search?q=$query&type=track'),
      headers: {'Authorization': 'Bearer $_accessToken'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
        
      return data['tracks']['items'].map<String>((track) {
        String name = track['name'];
        String artist = track['artists'][0]['name'];
        String imageUrl = track['album']['images'][0]['url'];


        return "$artist - $name - $imageUrl";
      }).toList();
    } else {
      throw Exception('Erro ao buscar músicas com a API do Spotify');
    }
  }
}
