import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:equatable/equatable.dart';
// ^^ For Testing Value Equality, since flutter doesn't have that out of the box
// which is something you'll probably want for unit testing

class SupabaseAuthFixture extends Equatable {
  static Stream<AuthState> unauthenticated() async* {
// ^^ static means we can call it without an instance of the class
// ^^ and the async* syntax allows us to return the stream type
    const user = User(
      id: '',
      email: '',
      appMetadata: {},
      userMetadata: {},
      aud: '',
      createdAt: "",
      updatedAt: "",
    );
    const session = Session(
      accessToken: '',
      refreshToken: '',
      expiresIn: 0,
      tokenType: '',
      user: user,
    );

    yield AuthState(AuthChangeEvent.userDeleted, session);
  }

  static Stream<AuthState> authenticated() async* {
    final user = User(
      id: 'id',
      email: 'test@example.com',
      appMetadata: {},
      userMetadata: {},
      aud: 'aud',
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );
    final session = Session(
      accessToken: 'access_token',
      refreshToken: 'refresh_token',
      expiresIn: 3600,
      tokenType: 'bearer',
      user: user,
    );
    yield AuthState(AuthChangeEvent.signedIn, session);
  }

  @override
  List<Object?> get props => [unauthenticated(), authenticated()];
}
