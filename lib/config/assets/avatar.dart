enum Avatar {
  woman(
    path: "assets/avatar",
    identifier: "woman"
  ),
  defaultAvatar(
    path: "",
    identifier: "",
  )

  ;
  const Avatar({required this.path, required this.identifier});  
  final String path;
  final String identifier;

  static Avatar getByIdentifier(String identifier) {
    return values.firstWhere((element) => element.identifier == identifier);
  }
}