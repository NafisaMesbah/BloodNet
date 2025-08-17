import 'package:bloodnet/Features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:bloodnet/Features/user_management/presentation/screens/registration_screen.dart';
import 'package:bloodnet/routes/go_router_refresh_stream.dart';
import 'package:go_router/go_router.dart';
import '../Features/user_management/presentation/screens/main_screen.dart';
import '../splash/splash_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:firebase_auth/firebase_auth.dart';

part 'routes.g.dart';

enum AppRoutes {
  splash,
  main,
  signIn,
  register,
  account,
  bloodGroupSelected,
  emailedUser,
  notification,
}

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    redirect: (constext, state) {
      final isLoggedIn = firebaseAuth.currentUser != null;

      if (isLoggedIn && (state.uri.toString() == '/signIn' ||
          state.uri.toString() == '/register')) {
        return '/main';
      } else if (!isLoggedIn && state.uri.toString().startsWith('/main')) {
        return '/signIn';
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(firebaseAuth.authStateChanges()),
    routes: [
      GoRoute(
        path: '/splash',
        name: AppRoutes.splash.name,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/main',
        name: AppRoutes.main.name,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/signIn',
        name: AppRoutes.signIn.name,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/register',
        name: AppRoutes.register.name,
        builder: (context, state) {
          final type= state.extra as String;
          return RegistrationScreen(type);
        }
      ),
    ],
  );
}
