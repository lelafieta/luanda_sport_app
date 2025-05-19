import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:luanda_sport_app/src/core/resources/app_icons.dart';

import '../../../../config/themes/app_colors.dart';

class AdeptHomePage extends StatefulWidget {
  const AdeptHomePage({super.key});

  @override
  State<AdeptHomePage> createState() => _AdeptHomePageState();
}

class _AdeptHomePageState extends State<AdeptHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Container(
              child: EasyDateTimeLine(
                initialDate: DateTime.now(),
                locale: "pt_BR",
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TitleWidget(
                    title: "Jogos em Directo",
                    callbackAction: () {},
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://assets.goal.com/images/v3/bltea8dbf2c3be62a24/WhatsApp_Image_2023-01-17_at_12.15.52_(1).jpeg?auto=webp&format=pjpg&width=1200&quality=60",
                      ),
                    ),
                  ),
                  TitleWidget(
                    title: "Últimas Notícias",
                    callbackAction: () {},
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        final league = Competition.fromJson(jsonData[index]);
                        return ClipOval(
                          child: Container(
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.2),
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: AppColors.color.withOpacity(.4),
                                width: 1,
                              ),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: league.logo,
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 16,
                        );
                      },
                      itemCount: jsonData.length,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final newss = NewsArticle.fromJson(news[index]);
                        return Container(
                          width: double.infinity,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 80,
                                height: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: newss.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      newss.title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.black,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppIcons.calendar,
                                          width: 16,
                                          color: AppColors.color,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text("10/10/2024 10:10"),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SvgPicture.asset(
                                          AppIcons.siteAlt,
                                          width: 16,
                                          color: AppColors.color,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(newss.sourceStr),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 20,
                        );
                      },
                      itemCount: news.length,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class JerseyPainter extends CustomPainter {
  final Color shirtColor;
  final Color stripeColor;
  final int number;

  JerseyPainter(
      {required this.shirtColor,
      required this.stripeColor,
      required this.number});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Camisa
    paint.color = shirtColor;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height * 0.6), paint);

    // Barra/listra
    paint.color = stripeColor;
    canvas.drawRect(Rect.fromLTWH(0, size.height * 0.2, size.width, 10), paint);

    // Número (como texto)
    final textPainter = TextPainter(
      text: TextSpan(
        text: number.toString(),
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(size.width / 2 - 10, size.height * 0.25));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class UniformModel {
  final Color shirtColor;
  final Color shortsColor;
  final Color stripeColor;
  final int number;
  final StripeStyle stripeStyle;

  UniformModel({
    required this.shirtColor,
    required this.shortsColor,
    required this.stripeColor,
    required this.number,
    required this.stripeStyle,
  });
}

enum StripeStyle { horizontal, vertical, diagonal }

class TitleWidget extends StatelessWidget {
  final String title;
  final VoidCallback? callbackAction;

  const TitleWidget({
    super.key,
    required this.title,
    this.callbackAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          const Text(
            "Ver todos",
            style: TextStyle(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

///

class NewsArticle {
  final String id;
  final String imageUrl;
  final String title;
  final String gmtTime;
  final String sourceStr;
  final String? sourceIconUrl; // Pode ser nulo
  final PageInfo page;

  NewsArticle({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.gmtTime,
    required this.sourceStr,
    this.sourceIconUrl,
    required this.page,
  });

  // Método para converter JSON em objeto NewsArticle
  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['id'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      gmtTime: json['gmtTime'],
      sourceStr: json['sourceStr'],
      sourceIconUrl: json['sourceIconUrl'],
      page: PageInfo.fromJson(json['page']),
    );
  }

  // Método para converter um objeto NewsArticle em JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'gmtTime': gmtTime,
      'sourceStr': sourceStr,
      'sourceIconUrl': sourceIconUrl,
      'page': page.toJson(),
    };
  }
}

class PageInfo {
  final String url;

  PageInfo({required this.url});

  // Método para converter JSON em objeto PageInfo
  factory PageInfo.fromJson(Map<String, dynamic> json) {
    return PageInfo(
      url: json['url'],
    );
  }

  // Método para converter um objeto PageInfo em JSON
  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }
}

class Competition {
  final int id;
  final String name;
  final String localizedName;
  final String logo;

  Competition({
    required this.id,
    required this.name,
    required this.localizedName,
    required this.logo,
  });

  // Método para converter JSON em objeto Competition
  factory Competition.fromJson(Map<String, dynamic> json) {
    return Competition(
      id: json['id'],
      name: json['name'],
      localizedName: json['localizedName'],
      logo: json['logo'],
    );
  }

  // Método para converter um objeto Competition em JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'localizedName': localizedName,
      'logo': logo,
    };
  }
}

final List<Map<String, dynamic>> jsonData = [
  {
    "id": 42,
    "name": "Champions League",
    "localizedName": "Champions League",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/42.png"
  },
  {
    "id": 73,
    "name": "Europa League",
    "localizedName": "Europa League",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/73.png"
  },
  {
    "id": 9470,
    "name": "AFC Challenge League",
    "localizedName": "AFC Challenge League",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9470.png"
  },
  {
    "id": 525,
    "name": "AFC Champions League Elite",
    "localizedName": "AFC Champions League Elite",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/525.png"
  },
  {
    "id": 10622,
    "name": "AFC Champions League Elite Qualification",
    "localizedName": "AFC Champions League Elite Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10622.png"
  },
  {
    "id": 9469,
    "name": "AFC Champions League Two",
    "localizedName": "AFC Champions League Two",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9469.png"
  },
  {
    "id": 10511,
    "name": "AFC Summer Olympics Qualification (Women)",
    "localizedName": "AFC Summer Olympics Qualification (Women)",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10511.png"
  },
  {
    "id": 9841,
    "name": "AFC U20 Asian Cup",
    "localizedName": "AFC U20 Asian Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9841.png"
  },
  {
    "id": 9265,
    "name": "AFF Championship",
    "localizedName": "AFF Championship",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9265.png"
  },
  {
    "id": 289,
    "name": "Africa Cup of Nations",
    "localizedName": "Africa Cup of Nations",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/289.png"
  },
  {
    "id": 10608,
    "name": "Africa Cup of Nations Qualification",
    "localizedName": "Africa Cup of Nations Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10608.png"
  },
  {
    "id": 10508,
    "name": "African Football League",
    "localizedName": "African Football League",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10508.png"
  },
  {
    "id": 9428,
    "name": "African Nations Championship",
    "localizedName": "African Nations Championship",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9428.png"
  },
  {
    "id": 9579,
    "name": "Algarve Cup (W)",
    "localizedName": "Algarve Cup (W)",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9579.png"
  },
  {
    "id": 10474,
    "name": "Arab Club Champions Cup",
    "localizedName": "Arab Club Champions Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10474.png"
  },
  {
    "id": 290,
    "name": "Asian Cup",
    "localizedName": "Asian Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/290.png"
  },
  {
    "id": 10609,
    "name": "Asian Cup  Qualification Playoff",
    "localizedName": "Asian Cup  Qualification Playoff",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10609.png"
  },
  {
    "id": 9833,
    "name": "Asian Games",
    "localizedName": "Asian Games",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9833.png"
  },
  {
    "id": 10656,
    "name": "Beta Squad vs Amp Charity",
    "localizedName": "Beta Squad vs Amp Charity",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10656.png"
  },
  {
    "id": 526,
    "name": "CAF Champions League",
    "localizedName": "CAF Champions League",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/526.png"
  },
  {
    "id": 10619,
    "name": "CAF Champions League Qualification",
    "localizedName": "CAF Champions League Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10619.png"
  },
  {
    "id": 9468,
    "name": "CAF Confed Cup",
    "localizedName": "CAF Confed Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9468.png"
  },
  {
    "id": 9467,
    "name": "CAF Super Cup",
    "localizedName": "CAF Super Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9467.png"
  },
  {
    "id": 9875,
    "name": "Campeones Cup",
    "localizedName": "Campeones Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9875.png"
  },
  {
    "id": 10611,
    "name": "Champions League Qualification",
    "localizedName": "Champions League Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10611.png"
  },
  {
    "id": 489,
    "name": "Club Friendlies",
    "localizedName": "Club Friendlies",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/489.png"
  },
  {
    "id": 9682,
    "name": "CONCACAF Central American Cup",
    "localizedName": "CONCACAF Central American Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9682.png"
  },
  {
    "id": 297,
    "name": "CONCACAF Champions Cup",
    "localizedName": "CONCACAF Champions Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/297.png"
  },
  {
    "id": 9656,
    "name": "CONCACAF Championship U20",
    "localizedName": "CONCACAF Championship U20",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9656.png"
  },
  {
    "id": 10621,
    "name": "CONCACAF Championship U20 Qualification",
    "localizedName": "CONCACAF Championship U20 Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10621.png"
  },
  {
    "id": 298,
    "name": "CONCACAF Gold Cup",
    "localizedName": "CONCACAF Gold Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/298.png"
  },
  {
    "id": 10603,
    "name": "CONCACAF Gold Cup Women",
    "localizedName": "CONCACAF Gold Cup Women",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10603.png"
  },
  {
    "id": 9821,
    "name": "CONCACAF Nations League",
    "localizedName": "CONCACAF Nations League",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9821.png"
  },
  {
    "id": 10216,
    "name": "Conference League",
    "localizedName": "Conference League",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10216.png"
  },
  {
    "id": 10615,
    "name": "Conference League Qualification",
    "localizedName": "Conference League Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10615.png"
  },
  {
    "id": 44,
    "name": "Copa America",
    "localizedName": "Copa America",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/44.png"
  },
  {
    "id": 10368,
    "name": "Copa America Femenina",
    "localizedName": "Copa America Femenina",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10368.png"
  },
  {
    "id": 45,
    "name": "Copa Libertadores",
    "localizedName": "Copa Libertadores",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/45.png"
  },
  {
    "id": 10618,
    "name": "Copa Libertadores Qualification",
    "localizedName": "Copa Libertadores Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10618.png"
  },
  {
    "id": 299,
    "name": "Copa Sudamericana",
    "localizedName": "Copa Sudamericana",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/299.png"
  },
  {
    "id": 10623,
    "name": "Copa Sudamericana Qualification",
    "localizedName": "Copa Sudamericana Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10623.png"
  },
  {
    "id": 300,
    "name": "East Asian Championship",
    "localizedName": "East Asian Championship",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/300.png"
  },
  {
    "id": 50,
    "name": "EURO",
    "localizedName": "EURO",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/50.png"
  },
  {
    "id": 10607,
    "name": "EURO Qualification",
    "localizedName": "EURO Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10607.png"
  },
  {
    "id": 287,
    "name": "EURO U19",
    "localizedName": "EURO U19",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/287.png"
  },
  {
    "id": 288,
    "name": "EURO U21",
    "localizedName": "EURO U21",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/288.png"
  },
  {
    "id": 10437,
    "name": "EURO U-21 Qualification",
    "localizedName": "EURO U-21 Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10437.png"
  },
  {
    "id": 10613,
    "name": "Europa League Qualification",
    "localizedName": "Europa League Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10613.png"
  },
  {
    "id": 301,
    "name": "European Championship U-17",
    "localizedName": "European Championship U-17",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/301.png"
  },
  {
    "id": 78,
    "name": "FIFA Club World Cup",
    "localizedName": "FIFA Club World Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/78.png"
  },
  {
    "id": 10703,
    "name": "FIFA Intercontinental Cup",
    "localizedName": "FIFA Intercontinental Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10703.png"
  },
  {
    "id": 10304,
    "name": "Finalissima",
    "localizedName": "Finalissima",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10304.png"
  },
  {
    "id": 114,
    "name": "Friendlies",
    "localizedName": "Friendlies",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/114.png"
  },
  {
    "id": 344,
    "name": "Friendlies U-21",
    "localizedName": "Friendlies U-21",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/344.png"
  },
  {
    "id": 329,
    "name": "Gulf Cup",
    "localizedName": "Gulf Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/329.png"
  },
  {
    "id": 10043,
    "name": "Leagues Cup",
    "localizedName": "Leagues Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10043.png"
  },
  {
    "id": 10649,
    "name": "NWSL x Liga MX",
    "localizedName": "NWSL x Liga MX",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10649.png"
  },
  {
    "id": 491,
    "name": "Recopa Sudamericana",
    "localizedName": "Recopa Sudamericana",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/491.png"
  },
  {
    "id": 9876,
    "name": "SAFF Championship",
    "localizedName": "SAFF Championship",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9876.png"
  },
  {
    "id": 9921,
    "name": "SheBelieves Cup (W)",
    "localizedName": "SheBelieves Cup (W)",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9921.png"
  },
  {
    "id": 10312,
    "name": "Sidemen Charity Match",
    "localizedName": "Sidemen Charity Match",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10312.png"
  },
  {
    "id": 9690,
    "name": "Southeast Asian Games",
    "localizedName": "Southeast Asian Games",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9690.png"
  },
  {
    "id": 66,
    "name": "Summer Olympics",
    "localizedName": "Summer Olympics",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/66.png"
  },
  {
    "id": 65,
    "name": "Summer Olympics (Women)",
    "localizedName": "Summer Olympics (Women)",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/65.png"
  },
  {
    "id": 10498,
    "name": "Summer Olympics Qualification CONCACAF (W)",
    "localizedName": "Summer Olympics Qualification CONCACAF (W)",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10498.png"
  },
  {
    "id": 9514,
    "name": "The Atlantic Cup",
    "localizedName": "The Atlantic Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9514.png"
  },
  {
    "id": 305,
    "name": "Toulon Tournament",
    "localizedName": "Toulon Tournament",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/305.png"
  },
  {
    "id": 9806,
    "name": "UEFA Nations League A",
    "localizedName": "UEFA Nations League A",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9806.png"
  },
  {
    "id": 10557,
    "name": "UEFA Nations League A Qualification",
    "localizedName": "UEFA Nations League A Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10557.png"
  },
  {
    "id": 10717,
    "name": "UEFA Nations League A Qualification",
    "localizedName": "UEFA Nations League A Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10717.png"
  },
  {
    "id": 9807,
    "name": "UEFA Nations League B",
    "localizedName": "UEFA Nations League B",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9807.png"
  },
  {
    "id": 10558,
    "name": "UEFA Nations League B Qualification",
    "localizedName": "UEFA Nations League B Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10558.png"
  },
  {
    "id": 10718,
    "name": "UEFA Nations League B Qualification",
    "localizedName": "UEFA Nations League B Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10718.png"
  },
  {
    "id": 10458,
    "name": "UEFA Nations League B Women",
    "localizedName": "UEFA Nations League B Women",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10458.png"
  },
  {
    "id": 9808,
    "name": "UEFA Nations League C",
    "localizedName": "UEFA Nations League C",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9808.png"
  },
  {
    "id": 10719,
    "name": "UEFA Nations League C Qualification",
    "localizedName": "UEFA Nations League C Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10719.png"
  },
  {
    "id": 10459,
    "name": "UEFA Nations League C Women",
    "localizedName": "UEFA Nations League C Women",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10459.png"
  },
  {
    "id": 9809,
    "name": "UEFA Nations League D",
    "localizedName": "UEFA Nations League D",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9809.png"
  },
  {
    "id": 74,
    "name": "UEFA Super Cup",
    "localizedName": "UEFA Super Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/74.png"
  },
  {
    "id": 10457,
    "name": "UEFA Women's Nations League",
    "localizedName": "UEFA Women's Nations League",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10457.png"
  },
  {
    "id": 9741,
    "name": "UEFA Youth League",
    "localizedName": "UEFA Youth League",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9741.png"
  },
  {
    "id": 10269,
    "name": "Womens Asian Cup",
    "localizedName": "Womens Asian Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10269.png"
  },
  {
    "id": 9375,
    "name": "Women's Champions League",
    "localizedName": "Women's Champions League",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/9375.png"
  },
  {
    "id": 10612,
    "name": "Women's Champions League Qualification",
    "localizedName": "Women's Champions League Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10612.png"
  },
  {
    "id": 292,
    "name": "Women's EURO Qualification",
    "localizedName": "Women's EURO Qualification",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/292.png"
  },
  {
    "id": 10640,
    "name": "Women's EURO Qualification League A",
    "localizedName": "Women's EURO Qualification League A",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10640.png"
  },
  {
    "id": 10641,
    "name": "Women's EURO Qualification League B",
    "localizedName": "Women's EURO Qualification League B",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10641.png"
  },
  {
    "id": 10642,
    "name": "Women's EURO Qualification League C",
    "localizedName": "Women's EURO Qualification League C",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10642.png"
  },
  {
    "id": 293,
    "name": "Women's Friendlies",
    "localizedName": "Women's Friendlies",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/293.png"
  },
  {
    "id": 76,
    "name": "Women's World Cup",
    "localizedName": "Women's World Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/76.png"
  },
  {
    "id": 77,
    "name": "World Cup",
    "localizedName": "FIFA World Cup",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/77.png"
  },
  {
    "id": 10358,
    "name": "World Cup Qualification (W) CONCAFAF",
    "localizedName": "World Cup Qualification (W) CONCAFAF",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10358.png"
  },
  {
    "id": 10359,
    "name": "World Cup Qualification (W) Inter-Confederation",
    "localizedName": "World Cup Qualification (W) Inter-Confederation",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10359.png"
  },
  {
    "id": 10357,
    "name": "World Cup Qualification (W) UEFA",
    "localizedName": "World Cup Qualification (W) UEFA",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10357.png"
  },
  {
    "id": 10197,
    "name": "World Cup Qualification AFC",
    "localizedName": "World Cup Qualification AFC",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10197.png"
  },
  {
    "id": 10196,
    "name": "World Cup Qualification CAF",
    "localizedName": "World Cup Qualification CAF",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10196.png"
  },
  {
    "id": 10198,
    "name": "World Cup Qualification CONCACAF",
    "localizedName": "World Cup Qualification CONCACAF",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10198.png"
  },
  {
    "id": 10199,
    "name": "World Cup Qualification CONMEBOL",
    "localizedName": "World Cup Qualification CONMEBOL",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10199.png"
  },
  {
    "id": 10201,
    "name": "World Cup Qualification Inter-confederation",
    "localizedName": "World Cup Qualification Inter-confederation",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10201.png"
  },
  {
    "id": 10200,
    "name": "World Cup Qualification OFC",
    "localizedName": "World Cup Qualification OFC",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10200.png"
  },
  {
    "id": 10195,
    "name": "World Cup Qualification UEFA",
    "localizedName": "World Cup Qualification UEFA",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/10195.png"
  },
  {
    "id": 306,
    "name": "World Cup U17",
    "localizedName": "World Cup U17",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/306.png"
  },
  {
    "id": 296,
    "name": "World Cup U20",
    "localizedName": "World Cup U20",
    "logo":
        "https://images.fotmob.com/image_resources/logo/leaguelogo/dark/296.png"
  }
];

final List<Map<String, dynamic>> news = [
  {
    "id": "ftbpro_01jfsmx4v7m4",
    "imageUrl":
        "https://images2.minutemediacdn.com/image/upload/c_crop,w_1915,h_1077,x_0,y_0/c_fill,w_912,h_516,f_auto,q_auto,g_auto/images/voltaxMediaLibrary/mmsport/90min_en_international_web/01jfsph4p9nxp3xdwzvy.jpg",
    "title":
        "Gary Neville: Why Man Utd's crushing loss to Bournemouth is 'massive positive' for Ruben Amorim",
    "gmtTime": "2024-12-23T13:00:00.000Z",
    "sourceStr": "90min",
    "sourceIconUrl": null,
    "page": {
      "url":
          "/embed/news/01jfsmx4v7m4/gary-neville-why-man-utds-crushing-loss-bournemouth-is-massive-positive-ruben-amorim"
    }
  },
  {
    "id": "ftbpro_01jfsrbs4wca",
    "imageUrl":
        "https://images2.minutemediacdn.com/image/upload/c_crop,w_3000,h_1687,x_0,y_153/c_fill,w_912,h_516,f_auto,q_auto,g_auto/images/GettyImages/mmsport/90min_en_international_web/01jfsrjsjxw962dwp8xp.jpg",
    "title":
        "Former Man Utd coach explains why Erik ten Hag overlooked Amad Diallo",
    "gmtTime": "2024-12-23T13:30:00.000Z",
    "sourceStr": "90min",
    "sourceIconUrl": null,
    "page": {
      "url":
          "/embed/news/01jfsrbs4wca/former-man-utd-coach-explains-why-erik-ten-hag-overlooked-amad-diallo"
    }
  },
  {
    "id": "ftbpro_01jfsha0v0m9",
    "imageUrl":
        "https://images2.minutemediacdn.com/image/upload/c_crop,w_1707,h_960,x_0,y_189/c_fill,w_912,h_516,f_auto,q_auto,g_auto/images/GettyImages/mmsport/90min_en_international_web/01jfshh5s4f6yt5p6vrf.jpg",
    "title": "Mohamed Salah provides short update on Liverpool contract saga",
    "gmtTime": "2024-12-23T12:00:02.000Z",
    "sourceStr": "90min",
    "sourceIconUrl": null,
    "page": {
      "url":
          "/embed/news/01jfsha0v0m9/mohamed-salah-provides-short-update-liverpool-contract-saga"
    }
  },
  {
    "id": "ftbpro_01jfsehnv9gm",
    "imageUrl":
        "https://images2.minutemediacdn.com/image/upload/c_crop,w_4000,h_2250,x_0,y_129/c_fill,w_912,h_516,f_auto,q_auto,g_auto/images/GettyImages/mmsport/90min_en_international_web/01jfsfhwbtts6czr0wqw.jpg",
    "title": "Barcelona take drastic measure to register Dani Olmo",
    "gmtTime": "2024-12-23T11:00:00.000Z",
    "sourceStr": "90min",
    "sourceIconUrl": null,
    "page": {
      "url":
          "/embed/news/01jfsehnv9gm/barcelona-take-drastic-measure-register-dani-olmo"
    }
  },
  {
    "id": "ftbpro_01jfspgcwry8",
    "imageUrl":
        "https://images2.minutemediacdn.com/image/upload/c_crop,w_3500,h_1968,x_0,y_115/c_fill,w_912,h_516,f_auto,q_auto,g_auto/images/GettyImages/mmsport/90min_en_international_web/01jfsq08z80ncj2h2vf8.jpg",
    "title":
        "Arne Slot sounds Liverpool warning while reacting to Chelsea draw",
    "gmtTime": "2024-12-23T14:00:01.000Z",
    "sourceStr": "90min",
    "sourceIconUrl": null,
    "page": {
      "url":
          "/embed/news/01jfspgcwry8/arne-slot-sounds-liverpool-warning-while-reacting-chelsea-draw"
    }
  }
];
