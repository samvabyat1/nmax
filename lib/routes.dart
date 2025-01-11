import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:nmax/navscreen.dart';
import 'package:nmax/screens/auth/first_screen.dart';
import 'package:nmax/screens/channels/channels_screen.dart';
import 'package:nmax/screens/direct/chat_screen.dart';
import 'package:nmax/screens/direct/direct_screen.dart';
import 'package:nmax/screens/profile/profile_screen.dart';

class MRoutes {
  GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => NavScreen(),
      ),
      GoRoute(
        path: '/h',
        builder: (context, state) => NavScreen(),
      ),
      GoRoute(
        path: '/m/:username',
        builder: (context, state) => ChatScreen(
          user: state.pathParameters['username'] ?? '',
        ),
      ),
      GoRoute(
        path: '/m',
        builder: (context, state) => DirectScreen(),
      ),
      GoRoute(
        path: '/c',
        builder: (context, state) => ChannelsScreen(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => FirstScreen(),
      ),
      GoRoute(
        path: '/i/:username',
        builder: (context, state) => ProfileScreen(
          username: state.pathParameters['username'] ?? '',
        ),
      ),
      GoRoute(
        path: '/i',
        builder: (context, state) => ProfileScreen(),
      ),
    ],
    redirect: (context, state) {
      print(state.matchedLocation);
      if (FirebaseAuth.instance.currentUser == null &&
          state.matchedLocation.startsWith('/i/') == false) return '/auth';
      return null;
    },
  );
}
