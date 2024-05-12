class UserIfo {
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final String xpPoints;

  UserIfo({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.xpPoints,
  });

  UserIfo copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? xpPoints,
  }) {
    return UserIfo(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      xpPoints: xpPoints ?? this.xpPoints,
    );
  }
}
