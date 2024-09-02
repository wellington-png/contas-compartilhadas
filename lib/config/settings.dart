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
  static String removeMember(int id) => 'groups/$id/remove-member/';
  // groups/8/add-expense
  static String addExpense(int id) => 'groups/$id/add-expense/';

  // Endpoints de despesas
  static String expenseList({
    int? groupId,
    String? dateSpentRangeAfter,
    String? dateSpentRangeBefore,
    bool? isFixed,
    int? month,
    int? year,
  }) {
    final queryParameters = {
      if (dateSpentRangeAfter != null)
        'date_spent_range_after': dateSpentRangeAfter,
      if (dateSpentRangeBefore != null)
        'date_spent_range_before': dateSpentRangeBefore,
      if (groupId != null) 'group': '$groupId',
      if (isFixed != null) 'is_fixed': '$isFixed',
      if (month != null) 'month': '$month',
      if (year != null) 'year': '$year',
    };

    final queryString = Uri(queryParameters: queryParameters).query;
    return 'expenses/?$queryString';
  }
  static const String expenseCreate = 'expenses/';
  static String expenseUpdate(int id) => 'expenses/$id/';
  static String expenseDelete(int id) => 'expenses/$id/';

}

typedef ProjetoGetter<T> = T Function();
