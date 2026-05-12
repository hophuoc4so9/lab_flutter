class TokenHandler {
  static final TokenHandler _instance = TokenHandler._internal();
  TokenHandler._internal(); 
  factory TokenHandler() {
    return _instance;
  }
  String _jwtToken = '';
  void addToken(String token) {
    if(token.isNotEmpty) {
      _jwtToken = token;
    }
  }
  String getToken() {
    return _jwtToken;
  }
  void clearToken() {
    _jwtToken = '';
  }
  
}