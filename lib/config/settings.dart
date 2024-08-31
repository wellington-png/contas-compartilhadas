class Settings {
  Settings();

  static const String baseUrl = 'https://wellington2.thunder.dev.br/api/';
}

class API {
  API();

  static const String token = 'token/';

  // Endpoints de usuários
  static const String userCreate = 'users/';
  static String userUpdate(int id) => 'users/$id/';
  static String userDelete(int id) => 'users/$id/';
  static const String userMe = 'users/me/';

  // Endpoints de grupos
  static const String groupList = 'groups/';
  static const String groupCreate = 'groups/';
  static String groupUpdate(int id) => 'groups/$id/';
  static String groupDelete(int id) => 'groups/$id/';
  static String groupDetails(int id) => 'groups/$id/details/';
  static String groupInviteEmail(id) => 'groups/$id/invite-email/';
}

typedef ProjetoGetter<T> = T Function();
