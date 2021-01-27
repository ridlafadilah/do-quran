part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthStatus.unknown,
    this.oAuthResult,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(OAuthResult oAuthResult)
      : this._(status: AuthStatus.authenticated, oAuthResult: oAuthResult);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  final AuthStatus status;
  final OAuthResult oAuthResult;

  @override
  List<Object> get props => [status, oAuthResult];
}
