class SignupRequestBodyEntity {
  final String name;
  final String email;
  final String password;
  final String avatar;
  final String role;

  SignupRequestBodyEntity({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.avatar,
  });
}
