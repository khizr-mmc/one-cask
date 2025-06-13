part of 'auth_cubit.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState({this.isPasswordObscured = true});

  final bool isPasswordObscured;

  AuthenticationState copyWith({bool? isPasswordObscured}) =>
      AuthenticationState(
        isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      );

  @override
  List<Object> get props => [isPasswordObscured];
}
