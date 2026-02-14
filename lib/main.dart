import 'package:ShopCraft/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';

import 'error_screen.dart';
import 'home_screen.dart';
import 'l10n/app_localizations.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

//language provider
final localProvider = StateProvider<Locale>((ref) {
  return const Locale('en');
});

final authProvider = StateProvider<bool>((ref) => true);
final atLandingProvider = StateProvider<bool>((ref) => true);

//router provider
final routerProvider = Provider<GoRouter>((ref) {
  final isLoggedIn = ref.watch(authProvider);

  final themeMode = ref.watch(themeModeProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final loggingIn = state.matchedLocation == '/login';
      final signingUp = state.matchedLocation == '/signup';
      final landing = state.matchedLocation == '/';


      print("state.matchedLocation : ${state.matchedLocation},");
      print("islogged in : ${isLoggedIn},");

      if (!isLoggedIn && !(signingUp || loggingIn)) {
        print("sent back");
        return '/';
      }
      if (isLoggedIn && (landing || signingUp || loggingIn)) {
        print("sent to home");

        return '/home';
      }

      return null;
    },

    routes: [
      ShellRoute(
        builder: (context, state, child) {

          return Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
              ),
            ),
            child: Stack(
              children: [
                Center(child: child),
                PositionedDirectional(
                  top: 10,
                  start: 10,
                  child: state.uri.path!='/'
                      ?
                  IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: Icon(Icons.arrow_back_rounded),
                        )
                      : const SizedBox.shrink(),
                ),
                PositionedDirectional( //theme mode
                  end: 8,
                  top: 0,
                  child: IconButton(
                    onPressed: () {
                      ref
                          .read(themeModeProvider.notifier)
                          .state = themeMode == ThemeMode.light
                          ? ThemeMode.dark
                          : ThemeMode.light;
                    },
                    icon: Icon(
                      themeMode == ThemeMode.light
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined,
                    ),
                  ),
                ),
                PositionedDirectional( // language
                  end: 50,
                  top: 0,
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          ref
                              .read(localProvider.notifier)
                              .state = ref.read(localProvider) == const Locale('en')
                              ? const Locale('ar')
                              : const Locale('en');
                       },
                        icon: Icon(Icons.translate_outlined),
                      ),
                      Text(
                        ref.watch(localProvider) == const Locale('en')
                            ? 'ar'
                            : 'en',
                        style: Theme.of(context).textTheme.bodySmall
                        ,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },

        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const LandScreen(),
              transitionDuration: const Duration(milliseconds: 600),
              reverseTransitionDuration: const Duration(milliseconds: 600),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: Tween<double>(
                        begin: 1,
                        end: 0,
                      ).animate(secondaryAnimation),
                      child: child,
                    );
                  },
            ),
          ),
          GoRoute(
            path: '/login',
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const LoginScreen(),
                transitionDuration: const Duration(seconds: 1), // Hero duration
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
              );
            },
          ),
          GoRoute(
            path: '/signup',
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const SignupScreen(),
                transitionDuration: const Duration(seconds: 1), // Hero duration
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
              );
            },
          ),
        ],
      ),

      GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    ],
    errorBuilder: (context, state) => const ErrorScreen(),
  );
});

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const ProviderScope(child: MyApp()));
}

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.dark    ; // or system
});

final lightColorScheme = ColorScheme(
  brightness: Brightness.light, // Indicates this is a light theme
  primary: Color(0xFF764BA2), // Purple
  // Used for:
  // - AppBar background if not overridden
  // - ElevatedButton background by default
  // - FloatingActionButton background
  // - Active elements / highlights
  onPrimary: Colors.white, // Text/icon color on top of primary
  // Used for:
  // - Text on buttons with primary background
  // - Icons on primary-colored widgets

  secondary: Color(0xFF667EEA), // Accent purple/blue
  // Used for:
  // - OutlinedButton / secondary actions
  // - Switches, sliders, toggle buttons
  // - Chips, selection highlights
  onSecondary: Colors.white,
  // Text/icons on secondary-colored elements
  surfaceContainer:Colors.white54 ,
  surface: Colors.white, // Main surface for cards and panels
  // Used for:
  // - Card backgrounds
  // - Dialogs
  // - Bottom sheets
  onSurface: Colors.black, // Text/icons on top of surface
  // Used for:
  // - Text in cards, dialogs, and sheets
  // - Icons on surfaces

  error: Colors.redAccent,
  // Used for:
  // - Error messages
  // - Error borders on inputs
  // - Snackbar errors
  onError: Colors.white,
  // Text/icons on error backgrounds

  background: Colors.white, // Legacy background (scaffold background)
  onBackground: Colors.black, // Text/icons on background
);

final darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF764BA2), // Purple
  // Used for:
  // - AppBar background
  // - ElevatedButton
  // - FloatingActionButton
  onPrimary: Colors.white,
  // Text/icons on primary-colored elements

  secondary: Color(0xFF667EEA), // Accent
  onSecondary: Colors.white,
  // Text/icons on secondary-colored elements
  surfaceContainer:Colors.black54 ,
  surface: Color(0xFF121212), // Dark gray panels
  // Used for:
  // - Card backgrounds
  // - Dialogs, bottom sheets
  // - Any container with "surface" background
  onSurface: Colors.white,
  // Text/icons on surface elements

  error: Colors.redAccent,
  errorContainer: Colors.red,
  onError: Colors.white,
  // Same as light theme but fits dark backgrounds

  background: Color(0xFF121212), // Main background of screens
  onBackground: Colors.white,
  // Text/icons on background
);
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final  colorTheme = ref.watch(themeModeProvider);
    final colorScheme= colorTheme == ThemeMode.light ? lightColorScheme : darkColorScheme;
    final locale = ref.watch(localProvider);
    return MaterialApp.router(

      theme: ThemeData(
        colorScheme: colorTheme == ThemeMode.light
            ? lightColorScheme
            : darkColorScheme,
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            color: colorScheme.onSurface,
            decoration: TextDecoration.none,
            fontSize: 16,
          ),
          bodyMedium:  TextStyle(
            color: colorScheme.onSurface,
            decoration: TextDecoration.none,
            fontSize: 14,
          ),
          bodySmall:  TextStyle(
            color: colorScheme.onSurface,
            decoration: TextDecoration.none,
            fontSize: 12,
          ),
          titleLarge:  TextStyle(
            color: colorScheme.onSurface,
            decoration: TextDecoration.none,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
          titleMedium:  TextStyle(
            color: colorScheme.onSurface,
            decoration: TextDecoration.none,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          titleSmall:  TextStyle(
            color: colorScheme.onSurface,
            decoration: TextDecoration.none,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          labelSmall:  TextStyle( color: colorScheme.error, fontSize: 14),
        ),

        // Make ALL links / clickable text lose their underline
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 16, // top & bottom
              horizontal: 24, // left & right
            ),

            foregroundColor:  colorScheme.onSecondary,
            backgroundColor:   colorScheme.secondary,
            textStyle: const TextStyle(
              decoration: TextDecoration.none,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          errorStyle: TextStyle(
            color: colorScheme.error, // error text color
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          helperStyle: TextStyle(
            color: colorScheme.onTertiary, // info text color
            fontSize: 12,
          ),
          floatingLabelStyle: TextStyle(
            color: colorScheme.onSurface, // label when focused
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorScheme.surface),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purpleAccent),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),

        // Default AppBar style
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor:  colorScheme.primary,
        ),
      ),


      routerConfig: ref.watch(routerProvider),
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
