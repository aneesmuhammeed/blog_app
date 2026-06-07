import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newflu/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:newflu/core/theme/theme.dart';
import 'package:newflu/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:newflu/feature/auth/presentation/pages/login_page.dart';
import 'package:newflu/feature/blog/presentation/pages/blog_page.dart';
import 'package:newflu/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => servicelocator<AppUserCubit>()),
        BlocProvider(create: (_) => servicelocator<AuthBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return BlogPage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
