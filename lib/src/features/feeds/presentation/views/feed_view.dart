import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import '../../../../core/utils/title_widget.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TitleWidget(
              title: "Próximos Jogos",
              callbackAction: () {},
            ),

            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: const Text(
                            "Exibição",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          width: 2,
                                          color: Colors.grey.shade200),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(children: [
                                              ClipOval(
                                                child: CachedNetworkImage(
                                                    width: 30,
                                                    height: 30,
                                                    fit: BoxFit.cover,
                                                    imageUrl:
                                                        "https://template.canva.com/EAF1_XF3BJ4/2/0/1600w-dbetIJWoTcY.jpg"),
                                              ),
                                              const SizedBox(width: 8),
                                              const Text(
                                                "Dourada FC",
                                                style: TextStyle(),
                                              ),
                                            ]),
                                          ),
                                          const Text("-")
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(children: [
                                              ClipOval(
                                                child: CachedNetworkImage(
                                                    width: 30,
                                                    height: 30,
                                                    fit: BoxFit.cover,
                                                    imageUrl:
                                                        "https://template.canva.com/EAGVBjukC4Q/1/0/1600w-2noOBANFgDY.jpg"),
                                              ),
                                              const SizedBox(width: 8),
                                              const Text(
                                                "Ell Fantasma",
                                                style: TextStyle(),
                                              ),
                                            ]),
                                          ),
                                          const Text("-")
                                        ],
                                      ),
                                      const SizedBox(width: 10),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: 50,
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [
                                    Center(
                                      child: SvgPicture.asset(
                                        AppIcons.football,
                                        width: 20,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      "20:00",
                                      style: TextStyle(
                                        // color: Colors.red,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text("Sábado, 17 de Maio 2025")
                ],
              ),
            ),
            // EasyDateTimeLine(
            //   initialDate: DateTime.now(),
            //   locale: "pt_BR",
            // ),
            const SizedBox(height: 20),
            TitleWidget(
              title: "Proximos Treinos",
              callbackAction: () {},
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl:
                      "https://assets.goal.com/images/v3/bltea8dbf2c3be62a24/WhatsApp_Image_2023-01-17_at_12.15.52_(1).jpeg?auto=webp&format=pjpg&width=1200&quality=60",
                ),
              ),
            ),
          ],
        ),
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
        style: const TextStyle(color: Colors.white, fontSize: 20),
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
    "logo": "https://template.canva.com/EAF1_XF3BJ4/2/0/1600w-dbetIJWoTcY.jpg"
  },
  {
    "id": 73,
    "name": "Europa League",
    "localizedName": "Europa League",
    "logo": "https://template.canva.com/EAGVBjukC4Q/1/0/1600w-2noOBANFgDY.jpg"
  },
  {
    "id": 9470,
    "name": "AFC Challenge League",
    "localizedName": "AFC Challenge League",
    "logo": "https://template.canva.com/EAF7iHWkPBk/2/0/1600w-Zg83G1121eU.jpg"
  },
  {
    "id": 525,
    "name": "AFC Champions League Elite",
    "localizedName": "AFC Champions League Elite",
    "logo": "https://template.canva.com/EAGHR-2mKCM/1/0/800w-_wVzUqzy2m8.jpg"
  },
  {
    "id": 10622,
    "name": "AFC Champions League Elite Qualification",
    "localizedName": "AFC Champions League Elite Qualification",
    "logo": "https://template.canva.com/EAGP4T4odfc/1/0/1600w-dIk478lEaYQ.jpg"
  },
  {
    "id": 9469,
    "name": "AFC Champions League Two",
    "localizedName": "AFC Champions League Two",
    "logo": "https://template.canva.com/EAGShYzCd9Y/1/0/800w-oWYlambiT4s.jpg"
  },
];
