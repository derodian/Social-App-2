class FirestorePath {
  // static String events = 'events';
  static String event(String id) => 'events/$id';
  static String events() => 'events';
  static String newsById(String id) => 'news/$id';
  static String news() => 'news';
  // static String users = 'user';
  static String users() => 'users';
  static String user(String uid) => 'users/$uid';
  static String avatar(String uid) => 'avatar/$uid';
  static String deviceToken(String uid) => 'device_token';
  static String committeMembers() => 'committe';
  static String committe(String uid) => 'committe/$uid';
}
