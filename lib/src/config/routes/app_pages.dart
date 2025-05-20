import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:luanda_sport_app/src/features/auth/presentation/pages/login_page.dart';
import 'package:luanda_sport_app/src/features/competitions/presentation/pages/my_competion_details_page.dart';
import 'package:luanda_sport_app/src/features/competitions/presentation/pages/create_competition_page.dart';
import 'package:luanda_sport_app/src/features/competitions/presentation/pages/my_competition_details_page.dart';
import 'package:luanda_sport_app/src/features/competitions/presentation/pages/list_my_competitions_page.dart';
import 'package:luanda_sport_app/src/features/game_on/presentation/game_on_page.dart';

import 'package:luanda_sport_app/src/features/live_games/presentation/pages/live_game_page.dart';
import 'package:luanda_sport_app/src/features/luanda_sport/presentation/pages/luanda_sport_page.dart';
import 'package:luanda_sport_app/src/features/organizers/presentation/pages/organizer_details_page.dart';
import 'package:luanda_sport_app/src/features/organizers/presentation/pages/organizer_page.dart';
import 'package:luanda_sport_app/src/features/splash&onboarding/presentation/pages/splash_page.dart';
import 'package:luanda_sport_app/src/features/teams/presentation/pages/list_my_teams.dart';
import '../../features/organizers/presentation/pages/organizer_home_page.dart';
import '../../features/players/presentation/pages/player_page.dart';
import '../../features/teams/domain/entities/team_entity.dart';
import '../../features/teams/presentation/pages/create_team_page.dart';
import '../../features/teams/presentation/pages/team_deatils_page.dart';
import 'app_routes.dart';

class AppPages {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.initial:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            // return LuandaSportPage();
            // return const SplashPage();
            return const LoginPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              child: child,
            );
          },
        );
      case AppRoutes.luandaSport:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return LuandaSportPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              child: child,
            );
          },
        );

      case AppRoutes.organizerDetails:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const OrganizerDetailsPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );
      case AppRoutes.competionDetails:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return CompetitionDetailsPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.liveGames:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const LiveGamePage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.listMyCompetitions:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const ListMyCompetitionsPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );
      case AppRoutes.myCompetitionDetails:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const MyCompetitionDetailsPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.createCompetition:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return CreateCompetitionPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.login:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const LoginPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.organizer:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const OrganizerPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.organizerHome:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const OrganizerHomePage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.listMyTeams:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const ListMyTeamsPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );
      case AppRoutes.createTeam:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const CreateTeamPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.teamDetails:
        final team = settings.arguments as TeamEntity;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return TeamDetailsPage(team: team);
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );
      case AppRoutes.players:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return PlayerPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      default:
        return MaterialPageRoute(builder: (_) => const UnknownPage());
    }
  }
}

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Unknown Page'),
      ),
    );
  }
}
