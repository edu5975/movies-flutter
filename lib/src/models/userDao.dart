class UserDao {
  int id;
  String user;
  String phone;
  String email;
  String picture;

  UserDao({
    this.id,
    this.user,
    this.phone,
    this.email,
    this.picture,
  });

  factory UserDao.fromJSON(Map<String, dynamic> map) {
    //Recibe json convertido a mapa
    return UserDao(
      id: map['id'],
      user: map['user'],
      phone: map['phone'],
      email: map['email'],
      picture: map['picture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user": user,
      "phone": phone,
      "email": email,
      "picture": picture,
    };
  }
}
