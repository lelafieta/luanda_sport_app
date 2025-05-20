import 'package:flutter/material.dart';
import '../../../coaches/presentation/screens/coach_screen.dart';
import '../../../competitions/presentation/pages/my_competition_details_page.dart';
import '../../../fans/presentation/screens/fan_screen.dart';
import '../../../organizers/presentation/screens/organizer_screen.dart';
import '../../../players/presentation/screens/player_screen.dart';
import '../../../referees/presentation/screens/referee_screen.dart';

class HomeScreen extends StatefulWidget {
  final Map<dynamic, String?>? arguments;
  const HomeScreen({super.key, this.arguments});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (widget.arguments == null) {
      content = const Text("NULL");
    } else {
      switch (widget.arguments!["pageParams"]) {
        case "player":
          content = const PlayerScreen();
          break;
        case "fan":
          content = const FanScreen();
          break;
        case "referee":
          content = const RefereeScreen();
          break;
        case "coach":
          content = const CoachScreen();
          break;
        case "organizer":
          content = const OrganizerScreen();
          break;
        default:
          content = const Center(child: Text('Tela padrão'));
      }
    }

    return content;
  }
}
