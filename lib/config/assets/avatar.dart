enum Avatar {
  baleia(
    path: "assets/images/avatars",
    identifier: "baleia",
    file: "baleia.png",
  ),
  camarao(
    path: "assets/images/avatars",
    identifier: "camarao",
    file: "camarao.png",
  ),
  caracol(
    path: "assets/images/avatars",
    identifier: "caracol",
    file: "caracol.png",
  ),
  cavaloMarinho(
    path: "assets/images/avatars",
    identifier: "cavalo-marinho",
    file: "cavalo-marinho.png",
  ),
  gato(
    path: "assets/images/avatars",
    identifier: "gato",
    file: "gato.png",
  ),
  homem1(
    path: "assets/images/avatars",
    identifier: "homem1",
    file: "homem1.png",
  ),
  mulher1(
    path: "assets/images/avatars",
    identifier: "mulher1",
    file: "mulher1.png",
  ),
  mulher2(
    path: "assets/images/avatars",
    identifier: "mulher2",
    file: "mulher2.png",
  ),
  mulher3(
    path: "assets/images/avatars",
    identifier: "mulher3",
    file: "mulher3.png",
  ),
  passaro(
    path: "assets/images/avatars",
    identifier: "passaro",
    file: "passaro.png",
  ),
  pato(
    path: "assets/images/avatars",
    identifier: "pato",
    file: "pato.png",
  ),
  porco(
    path: "assets/images/avatars",
    identifier: "porco",
    file: "porco.png",
  ),
  rato(
    path: "assets/images/avatars",
    identifier: "rato.png",
    file: "rato.png",
  ),
  zebra(
    path: "assets/images/avatars",
    identifier: "zebra",
    file: "zebra.png",
  ),
  defaultAvatar(
    path: "assets/images/avatars",
    identifier: "defaultAvatar",
    file: "passaro.png",
  );

  const Avatar({required this.path, required this.identifier, required this.file});

  final String path;
  final String identifier;
  final String file;

  static Avatar getByIdentifier(String identifier) {
    return values.firstWhere((element) => element.identifier == identifier);
  }

  String get fullPath => "$path/$file";
}