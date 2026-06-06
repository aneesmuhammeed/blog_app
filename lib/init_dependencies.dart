import 'package:get_it/get_it.dart';
import 'package:newflu/core/secrets/supabase_secrets.dart';
import 'package:newflu/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:newflu/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:newflu/feature/auth/domain/repository/auth_repository.dart';
import 'package:newflu/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:newflu/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final servicelocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: SupabaseSecrets.supabaseUrl,
    anonKey: SupabaseSecrets.anonKey,
  );
  servicelocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  servicelocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(servicelocator<SupabaseClient>()),
  );

  servicelocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(servicelocator()));

  servicelocator.registerFactory(() => UserSignUp(servicelocator()));

  servicelocator.registerLazySingleton(() => AuthBloc(userSignUp: servicelocator()));
}
