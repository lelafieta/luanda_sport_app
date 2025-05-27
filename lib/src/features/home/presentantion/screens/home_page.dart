import 'package:flutter/material.dart';
import '../../../coaches/presentation/screens/coach_screen.dart';
import '../../../fans/presentation/screens/fan_screen.dart';
import '../../../feeds/presentation/views/feed_view.dart';
import '../../../organizers/presentation/screens/organizer_screen.dart';
import '../../../players/presentation/pages/player_page.dart';
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
          content = const PlayerPage();
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

        case "feed":
          content = const FeedPage();
          break;
        default:
          content = const Center(child: Text('Tela padrão'));
      }
    }

    return content;
  }
}
