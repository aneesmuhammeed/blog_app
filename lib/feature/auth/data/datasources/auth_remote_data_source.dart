abstract interface class AuthRemoteDataSource {
  Future<String> signUpWithEmailPassword({
    required String password,
    required String email,
    required String name,
  });

  Future<String> loginInWithEmailPassword({
    required String password,
    required String email,
  });
}


// class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{

// }