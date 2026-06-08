import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:newflu/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:newflu/core/network/connection_checker.dart';
import 'package:newflu/core/secrets/supabase_secrets.dart';
import 'package:newflu/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:newflu/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:newflu/feature/auth/domain/repository/auth_repository.dart';
import 'package:newflu/feature/auth/domain/usecases/current_user.dart';
import 'package:newflu/feature/auth/domain/usecases/user_log_in.dart';
import 'package:newflu/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:newflu/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:newflu/feature/blog/data/datasources/blog_local_data_source.dart';
import 'package:newflu/feature/blog/data/datasources/blog_remote_data_source.dart';
import 'package:newflu/feature/blog/data/repositories/blog_repositories_impl.dart';
import 'package:newflu/feature/blog/domain/repositories/blog_repository.dart';
import 'package:newflu/feature/blog/domain/usecases/get_all_blogs.dart';
import 'package:newflu/feature/blog/domain/usecases/upload_blog.dart';
import 'package:newflu/feature/blog/presentation/bloc/blog_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final servicelocator = GetIt.instance;

Future<void> initDependencies() async {
  _initBlog();
  _initAuth();
  final supabase = await Supabase.initialize(
    url: SupabaseSecrets.supabaseUrl,
    anonKey: SupabaseSecrets.anonKey,
  );

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  servicelocator.registerLazySingleton(() => Hive.box(name: 'blogs'));

  servicelocator.registerLazySingleton(() => supabase.client);
  servicelocator.registerLazySingleton(() => AppUserCubit());

  servicelocator.registerFactory(() => InternetConnection());

  servicelocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(servicelocator()),
  );
}

void _initAuth() {
  servicelocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(servicelocator<SupabaseClient>()),
  );

  servicelocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(servicelocator(), servicelocator()),
  );

  servicelocator.registerFactory(() => UserSignUp(servicelocator()));
  servicelocator.registerFactory(() => UserLogIn(servicelocator()));
  servicelocator.registerFactory(() => CurrentUser(servicelocator()));

  servicelocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: servicelocator(),
      userLogIn: servicelocator(),
      currentUser: servicelocator(),
      appUserCubit: servicelocator(),
    ),
  );
}

void _initBlog() {
  servicelocator.registerFactory<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImpl(servicelocator<SupabaseClient>()),
  );

  servicelocator.registerFactory<BlogLocalDataSource>(
    () => BlogLocalDataSourceImpl(servicelocator()),
  );

  servicelocator.registerFactory<BlogRepository>(
    () => BlogRepositoryImpl(
      servicelocator(),
      servicelocator(),
      servicelocator(),
    ),
  );

  servicelocator.registerFactory(() => UploadBlog(servicelocator()));
  servicelocator.registerFactory(() => GetAllBlogs(servicelocator()));

  servicelocator.registerLazySingleton(
    () => BlogBloc(
      uploadBlog: servicelocator<UploadBlog>(),
      getAllBlogs: servicelocator<GetAllBlogs>(),
    ),
  );
}
