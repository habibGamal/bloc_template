// import 'package:bloc_app/business/bloc/interceptor_bloc.dart';
import 'package:bloc_app/business/bloc/auth_bloc.dart';
import 'package:bloc_app/business/bloc/interceptor_bloc.dart';
import 'package:bloc_app/business/bloc/posts_bloc.dart';
import 'package:bloc_app/constants/screens.dart';
import 'package:bloc_app/hooks/use_interceptor.dart';
import 'package:bloc_app/pages/add_coupon.dart';
import 'package:bloc_app/pages/classroom_screen.dart';
import 'package:bloc_app/pages/first_time_screen.dart';
import 'package:bloc_app/pages/forget_password.dart';
import 'package:bloc_app/pages/login_screen.dart';
import 'package:bloc_app/pages/playlist_page.dart';
import 'package:bloc_app/pages/set_new_pass_screen.dart';
import 'package:bloc_app/pages/signup_screen.dart';
import 'package:bloc_app/pages/verify_code_screen.dart';
import 'package:bloc_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooked_bloc/hooked_bloc.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final buttonStyle = ButtonStyle(
      textStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      shape: WidgetStateProperty.all(
        const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
    return bloc.MultiBlocProvider(
      providers: [
        bloc.BlocProvider(create: (context) => InterceptorBloc()),
        bloc.BlocProvider(
            create: (context) => PostsBloc(context.read<InterceptorBloc>())),
        bloc.BlocProvider(
          create: (context) => AuthBloc(context.read<InterceptorBloc>()),
        )
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF2196F3),
            ),
            useMaterial3: true,
            buttonTheme: const ButtonThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            filledButtonTheme: FilledButtonThemeData(
              style: buttonStyle,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: buttonStyle,
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: buttonStyle,
            ),
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme.copyWith(
                  headlineLarge: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                  ),
                  headlineMedium: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  bodySmall: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  labelMedium: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54)),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          initialRoute: Screens.classroom,
          routes: {
            Screens.firstTime: (context) => const FirstTimeScreen(),
            Screens.login: (context) => LoginScreen(),
            Screens.signup: (context) => SignupScreen(),
            Screens.forgetPassword: (context) => ForgetPasswordScreen(),
            Screens.setNewPassword: (context) => SetNewPassScreen(),
            Screens.verifyCode: (context) => VerifyCodeScreen(),
            Screens.addCoupon: (context) => AddCouponScreen(),
            Screens.classroom: (context) => ClassroomScreen(),
            Screens.playlist: (context) => PlaylistPage(),
            // Screens.loading: (context) => const LoadingScreen(),
            // Screens.noInternet: (context) => const NoInternetScreen(),
            // Screens.timeout: (context) => const TimeoutScreen(),
            // Screens.authHome: (context) => const AuthHomeScreen(),
          }),
    );
  }
}

class LoadingScreen extends HookWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useInterceptor();
    final auth = useBloc<AuthBloc>();
    useEffect(() {
      auth.add(TryAuthEvent());
      return null;
    }, []);
    useBlocListener(auth, (auth, value, context) {
      final state = value as AuthState;
      print(state.status);
      if (state.status == AuthStatus.authenticated) {
        AuthService.of(context).authenticated();
      } else if (state.status == AuthStatus.guest) {
        Navigator.of(context).pushNamed(Screens.login);
      }
    });

    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class MyHomePage extends HookWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    useInterceptor();
    final auth = useBloc<AuthBloc>();
    useBlocListener(auth, (auth, value, context) {
      final state = value as AuthState;
      print(state.token);
      if (state.status == AuthStatus.authenticated) {
        AuthService.of(context).authenticated(state.token!);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Login screen',
            ),
            ElevatedButton(
                onPressed: () =>
                    {auth.add(LoginEvent('habibmisi3@gmail.com', 'Gh090807'))},
                child: const Text("Login"))
          ],
        ),
      ),
    );
  }
}

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('No internet connection')));
  }
}

class TimeoutScreen extends StatelessWidget {
  const TimeoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Server Timeout')));
  }
}

class AuthHomeScreen extends HookWidget {
  const AuthHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = useBloc<AuthBloc>();
    useBlocListener(auth, (auth, value, context) {
      final state = value as AuthState;
      if (state.status == AuthStatus.guest) {
        AuthService.of(context).logout();
      }
    });
    return Scaffold(
        body: Center(
            child: Column(children: [
      const Text('Auth Home'),
      ElevatedButton(
          onPressed: () {
            auth.add(Logout());
          },
          child: const Text('Logout')),
    ])));
  }
}
