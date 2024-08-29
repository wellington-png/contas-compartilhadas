class Settings {
  Settings();

  static const String baseUrl = 'https://wellington2.thunder.dev.br/api/';
}

class API {
  API();

  static const String token = 'token/';

  static const Map<String, String> user = {
    'create': 'users/',
    'update': 'users/',
    'delete': 'users/',
    'me': 'users/me/',
  };

  static const Map<String, String> group = {
    'list': 'groups/',
    'create': 'groups/',
    'update': 'groups/',
    'delete': 'groups/',
  };
}

typedef ProjetoGetter<T> = T Function();
