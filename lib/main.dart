import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pokedex/ui/screens.dart';
import 'package:pokedex/ui/yourteam/yourteam_manager.dart';
import 'ui/yourteam/yourteam_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AuthManager(),
        ),
        ChangeNotifierProxyProvider<AuthManager, PokeManager>(
          create: (ctx) => PokeManager(),
          update: (ctx, authManager, pokeManager) {
            pokeManager!.authToken = authManager.authToken;
            return pokeManager;
          },
        ),
        ChangeNotifierProvider(
          create: (ctx) => poketeamManager(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => YourteamsManager(),
        ),
      ],
      child: Consumer<AuthManager>(builder: (context, authManager, child) {
        return MaterialApp(
          title: 'Pokedex',
          theme: ThemeData(
            fontFamily: 'Lato',
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.purple,
            ).copyWith(
              secondary: Colors.deepOrange,
            ),
          ),
          home: authManager.isAuth
              ? const PokeOverviewScreen()
              : FutureBuilder(
                  future: authManager.tryAutoLogin(),
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const SplashScreen()
                        : const AuthScreen();
                  },
                ),
          routes: {
            PoketeamScreen.routeName: (ctx) => const PoketeamScreen(),
            YourteamScreen.routeName: (ctx) => const YourteamScreen(),
            UserPokeScreen.routeName: (ctx) => const UserPokeScreen(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == PokeDetailScreen.routeName) {
              final pokemonId = settings.arguments as String;
              return MaterialPageRoute(
                builder: (ctx) {
                  return PokeDetailScreen(
                    ctx.read<PokeManager>().findById(pokemonId)!,
                  );
                },
              );
            }
            if (settings.name == EditPokeScreen.routeName) {
              final pokemonId = settings.arguments as String?;
              return MaterialPageRoute(
                builder: (ctx) {
                  return EditPokeScreen(
                    pokemonId != null
                        ? ctx.read<PokeManager>().findById(pokemonId)
                        : null,
                  );
                },
              );
            }
            return null;
          },
        );
      }),
    );
  }
}
