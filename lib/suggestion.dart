class Suggestion {
  final int id;
  final String name;
  final int isFavourite;

  Suggestion({this.id, this.name, this.isFavourite});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'isFavourite': isFavourite};
  }
}