part of 'init_dependencies.dart';

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
