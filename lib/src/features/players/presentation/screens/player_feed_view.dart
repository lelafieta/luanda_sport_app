import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luanda_sport_app/src/features/matches/domain/entities/cartaz_entity.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import '../../../matches/presentation/views/match_cartaz_view.dart';
import 'print_image.dart';

class PlayerFeedView extends StatefulWidget {
  const PlayerFeedView({super.key});

  @override
  State<PlayerFeedView> createState() => _PlayerFeedViewState();
}

class _PlayerFeedViewState extends State<PlayerFeedView> {
  // Simulações para exemplo
  final bool convocado = true;
  final bool noOnzeInicial = true;
  final bool isTreino = true; // true para mostrar treino

  // Detalhes do evento atual
  final String adversario = "Petro de Luanda";
  final String dataEvento = "Dom, 26 de Maio - 15h30";
  final String estadio = "Estádio 11 de Novembro";
  final String posicao = "Meio-Campo";

  // Próximos treinos (simulação)
  final List<Map<String, String>> proximosTreinos = [
    {"data": "Seg, 27 de Maio - 08h00", "local": "Campo Anexo 1"},
    {"data": "Qua, 29 de Maio - 16h00", "local": "Campo Principal"},
    {"data": "Sex, 31 de Maio - 10h00", "local": "Centro de Treinamento"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const TitleWidget(title: "Meu Estatus na equipe")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: convocado ? Colors.green[100] : Colors.red[100],
                child: ListTile(
                  leading: Icon(
                    convocado ? Icons.check_circle : Icons.cancel,
                    color: convocado ? Colors.green : Colors.red,
                  ),
                  title: Text(
                    convocado
                        ? "Você foi convocado para a equipe!"
                        : "Você não foi convocado.",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                color: noOnzeInicial ? Colors.blue[100] : Colors.grey[300],
                child: ListTile(
                  leading: Icon(
                    noOnzeInicial ? Icons.star : Icons.star_border,
                    color: noOnzeInicial ? Colors.blue : Colors.grey,
                  ),
                  title: Text(
                    noOnzeInicial
                        ? "Você está no 11 inicial!"
                        : "Você não está no 11 inicial.",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    final CartazEntity cartazExemplo = CartazEntity(
                      titulo: "Final do Campeonato Municipal",
                      equipeCasa: "Futebol Clube Luanda",
                      equipeVisitante: "Benfica de Talatona",
                      imagemEquipeCasa:
                          "https://template.canva.com/EAF1_XF3BJ4/2/0/1600w-dbetIJWoTcY.jpg",
                      imagemEquipeVisitante:
                          "https://template.canva.com/EAGVBjukC4Q/1/0/1600w-2noOBANFgDY.jpg",
                      logoCompeticao:
                          "https://example.com/imagens/campeonato-logo.png",
                      dataHora: DateTime(2025, 6, 15, 16, 30),
                      local: "Estádio 11 de Novembro",
                      descricao: 'Descrição do jogo',
                    );
                    context.pushTransparentRoute(SecondPage(
                      cartaz: cartazExemplo,
                    ));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      showGameWithCard(),
                      // const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                        ),
                        child: const Text("Sábado, 17 de Maio 2025"),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                color: Colors.teal[100],
                child: ListTile(
                  leading: const Icon(Icons.person_pin, color: Colors.teal),
                  title: const Text(
                    "Sua Posição",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(posicao),
                ),
              ),
              if (convocado) ...[
                const SizedBox(height: 16),
                Card(
                  color: isTreino ? Colors.yellow[100] : Colors.orange[100],
                  child: ListTile(
                    leading: Icon(
                      isTreino ? Icons.fitness_center : Icons.sports_soccer,
                      color: isTreino ? Colors.amber : Colors.orange,
                    ),
                    title: Text(
                      isTreino
                          ? "Treino programado"
                          : "Próximo Jogo: contra $adversario",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Data: $dataEvento"),
                        Text("Local: $estadio"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (isTreino && proximosTreinos.isNotEmpty)
                  Card(
                    elevation: 2,
                    color: Colors.red[50],
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Próximos Treinos",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...proximosTreinos.map((treino) => ListTile(
                                leading: const Icon(Icons.schedule,
                                    color: Colors.red),
                                title: Text(treino['data']!),
                                subtitle: Text(treino['local']!),
                              )),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
              ],
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget showGame() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            child: const Text(
              "Exibição",
              style: TextStyle(
                // color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        right:
                            BorderSide(width: 2, color: Colors.grey.shade200),
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
    );
  }

  Widget showGameWithCard() {
    return Column(
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: AppColors.primary),
              ),
            ),
            onPressed: () {
              print("object");
              context.pushTransparentRoute(PosterExportPage());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppIcons.images,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                const Text(
                  "Partilhar do cartaz",
                  style: TextStyle(color: AppColors.lightWightColor),
                ),
              ],
            )),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                child: const Text(
                  "Exibição",
                  style: TextStyle(
                    // color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    )),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                                width: 2, color: Colors.grey.shade200),
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
      ],
    );
  }
}

const imageUrl =
    'https://user-images.githubusercontent.com/26390946/155666045-aa93bf48-f8e7-407c-bb19-bc247d9e12bd.png';

class SecondPage extends StatelessWidget {
  final CartazEntity cartaz;

  const SecondPage({super.key, required this.cartaz});
  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      isFullScreen: false,
      disabled: false,
      minRadius: 10,
      maxRadius: 10,
      dragSensitivity: 1.0,
      maxTransformValue: .8,
      direction: DismissiblePageDismissDirection.multi,
      backgroundColor: Colors.black,
      onDragStart: () {
        print('onDragStart');
      },
      onDragUpdate: (details) {
        print(details);
      },
      dismissThresholds: const {
        DismissiblePageDismissDirection.vertical: .2,
      },
      minScale: .8,
      startingOpacity: 1,
      reverseDuration: const Duration(milliseconds: 250),
      onDismissed: () {
        Navigator.of(context).pop();
      },
      child: MatchCartazView(cartaz: cartaz),
    );
  }
}
