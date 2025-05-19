import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:uuid/uuid.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/app_icons.dart';

class CreateCompetitionPage extends StatefulWidget {
  const CreateCompetitionPage({super.key});

  @override
  State<CreateCompetitionPage> createState() => _CreateCompetitionPageState();
}

class _CreateCompetitionPageState extends State<CreateCompetitionPage> {
  final _formKeyStep0 = GlobalKey<FormBuilderState>();
  final _formKeyStep1 = GlobalKey<FormBuilderState>();
  final _formKeyStep2 = GlobalKey<FormBuilderState>();
  final _formKeyStep3 = GlobalKey<FormBuilderState>();
  final _formKey = GlobalKey<FormBuilderState>();
  int _currentStep = 0;
  int rounds = 13;
  int roundDuration = 7;
  int pauseDuration = 0;

  // Dados da competição

  final types = {
    'league': 'Liga (Pontos Corridos)',
    'cup': 'Copa (Eliminatória Directa)',
    'group_tournament': 'Torneio em Grupo + Eliminatórias'
  };

  final categories = {
    'local': 'Local',
    'national': 'Nacional',
    'international': 'Internacional',
  };
  final gameTypes = {
    '2X2': '2X2',
    '3X3': '3X3',
    '4X4': '4X4',
    '5X5': '5X5',
    '6X6': '6X6',
    '7X7': '7X7',
    '8X8': '8X8',
    '9X9': '9X9',
    '10X10': '10X10',
    '11X11': '11X11',
  };

  final typeOfPlayers = ['Homens', 'Munlheres'];

  TextEditingController name = TextEditingController();
  TextEditingController season = TextEditingController();
  TextEditingController type = TextEditingController(text: "league");
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController registrationDeadlineDate = TextEditingController();
  TextEditingController category = TextEditingController(text: "local");
  TextEditingController gameType = TextEditingController(text: "7X7");
  TextEditingController location = TextEditingController(text: "");

  TextEditingController playerType = TextEditingController(text: "male");
  TextEditingController level = TextEditingController();
  TextEditingController pointsVictory = TextEditingController(text: "3");
  TextEditingController pointsDraw = TextEditingController(text: "1");
  TextEditingController pointsLose = TextEditingController(text: "0");
  TextEditingController substitutionsAllowed = TextEditingController(text: "5");
  TextEditingController maxPlayers = TextEditingController(text: "15");
  TextEditingController maxTeams = TextEditingController(text: "16");

  TextEditingController isForChampionValue = TextEditingController(text: "0");
  TextEditingController isForTopScorerValue = TextEditingController(text: "0");
  TextEditingController isForFairPlayValue = TextEditingController(text: "0");
  TextEditingController groupQtd = TextEditingController();

  bool drawsAllowed = true;
  bool extraTimeAllowed = true;
  int matchDuration = 60;
  int restTime = 10;
  int extraTimeDuration = 8;
  bool penaltyAllowed = true;
  bool isHomeAndAway = false;

  bool isForChampion = true;
  bool isForTopScorer = true;
  bool isForFairPlay = true;
  double latitude = 0.0;
  double longitude = 0.0;

  List<String> tiebreakersSelected = ["goal_difference"];
  List<Map<String, String>> tiebreakers = [
    {'goal_difference': 'Diferença de gols'},
    {'goals_scored': 'Gols marcados'},
    {'head_to_head': 'Confronto direto'},
    {'wins': 'Vitórias'},
    {'fair_play': 'Fair play (cartões)'},
    {'random_draw': 'Sorteio'},
  ];

  void nextStep() {
    if (_currentStep == 0 && _formKeyStep0.currentState!.saveAndValidate()) {
      setState(() {
        _currentStep++;
      });
    } else if (_currentStep == 1 &&
        _formKeyStep1.currentState!.saveAndValidate()) {
      setState(() {
        _currentStep++;
      });
    } else if (_currentStep == 2 &&
        _formKeyStep2.currentState!.saveAndValidate()) {
      setState(() {
        _currentStep++;
      });
    } else if (_currentStep == 3 &&
        _formKeyStep3.currentState!.saveAndValidate()) {
      setState(() {
        _currentStep++;
      });
    }

    // final requiresValidation = _currentStep == 0 || (_currentStep == 2);

    // if (!requiresValidation ||
    //     (_formKeyStep0.currentState?.saveAndValidate() ?? false)) {
    //   setState(() {
    //     if (_currentStep < 4) {
    //       _currentStep++;
    //     } else {
    //       _submit();
    //     }
    //   });
    // } else {
    //   print(" Formulário inválido.");
    // }
  }

  void previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _submit() {
    // final competition = {
    //   'id': const Uuid().v4(),
    //   'name': name,
    //   'season': season,
    //   'type': type,
    //   'is_home_and_away': isHomeAndAway,
    //   'has_group_stage': hasGroupStage,
    //   'number_of_groups': hasGroupStage ? numberOfGroups : null,
    //   'organizer': organizer,
    //   'level': level,
    //   'start_date': startDate?.toIso8601String(),
    //   'end_date': endDate?.toIso8601String(),
    //   'rules': _formKey.currentState?.value,
    // };

    print('✅ Competição criada com regulamento:\n\$competition');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Competição criada com sucesso!')),
    );
  }

  Widget _buildStep() {
    switch (_currentStep) {
      case 0:
        return _basicInfoStep();
      case 1:
        return _basicInfoStep1();
      case 2:
        return _rulesStep();
      case 3:
        return _prizesStep();
      case 4:
        return _reviewStep();
      default:
        return const SizedBox();
    }
  }

  Widget _basicInfoStep() {
    return FormBuilder(
      key: _formKeyStep0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormBuilderTextField(
              name: 'name',
              controller: name,
              decoration:
                  const InputDecoration(labelText: 'Nome da competição'),
              onChanged: (v) => name.text = v ?? '',
              validator: FormBuilderValidators.required(
                  errorText: "Campo obrigatório"),
            ),
            const SizedBox(height: 15),
            FormBuilderTextField(
              name: 'season',
              controller: season,
              decoration:
                  const InputDecoration(labelText: 'Temporada (ex: 2025)'),
              onChanged: (v) => season.text = v ?? '',
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: "Campo obrigatório"),
                FormBuilderValidators.numeric(
                    errorText: "Apenas números são permitidos"),
              ]),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 15),
            FormBuilderDropdown<String>(
              name: 'type',
              initialValue: type.text,
              items: types.entries
                  .map((t) =>
                      DropdownMenuItem(value: t.key, child: Text(t.value)))
                  .toList(),
              onChanged: (v) => setState(() => type.text = v!),
              decoration:
                  const InputDecoration(labelText: 'Tipo de competição'),
              validator: FormBuilderValidators.required(
                  errorText: "Campo obrigatório"),
            ),
            const SizedBox(height: 15),
            (type.text == 'group_tournament')
                ? Column(
                    children: [
                      FormBuilderTextField(
                        name: 'group_qtd',
                        controller: groupQtd,
                        decoration: const InputDecoration(
                            labelText: 'Número de grupos'),
                        keyboardType: TextInputType.number,
                        validator: (type.text == 'group_tournament')
                            ? FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText: "Campo obrigatório"),
                                FormBuilderValidators.numeric(
                                    errorText: "Apenas valores numéricos"),
                              ])
                            : null,
                      ),
                      const SizedBox(height: 15),
                    ],
                  )
                : const SizedBox.shrink(),
            FormBuilderTextField(
              name: 'location',
              controller: location,
              decoration: const InputDecoration(labelText: 'Localização'),
              keyboardType: TextInputType.number,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: "Campo obrigatório"),
              ]),
            ),
            const SizedBox(height: 15),
            const Text("Inscrição na competição",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const SizedBox(height: 15),
            FormBuilderTextField(
              name: 'max_teams',
              controller: maxTeams,
              decoration: const InputDecoration(labelText: 'Total de equipe'),
              keyboardType: TextInputType.number,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: "Campo obrigatório"),
                FormBuilderValidators.numeric(
                    errorText: "Apenas valor numérico"),
                FormBuilderValidators.max(100,
                    errorText: "O valor máximo permitido é 100"),
              ]),
            ),
            const SizedBox(height: 15),
            FormBuilderTextField(
              name: 'max_players',
              controller: maxPlayers,
              decoration: const InputDecoration(
                  labelText: 'Número máximo de jogadores por equipe'),
              keyboardType: TextInputType.number,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: "Campo obrigatório"),
                FormBuilderValidators.numeric(
                    errorText: "Apenas valor numérico"),
                FormBuilderValidators.max(25,
                    errorText: "O valor máximo permitido é 100"),
              ]),
            ),
            const SizedBox(height: 15),
            FormBuilderTextField(
              name: "registration_deadline",
              controller: registrationDeadlineDate,
              decoration: const InputDecoration(labelText: 'Última da registo'),
              readOnly: true,
              onTap: () {
                _openDatePickerRegistrationDeadline(context);
              },
            ),
            const SizedBox(height: 15),
            FormBuilderTextField(
              name: "start_date",
              controller: startDate,
              decoration: const InputDecoration(labelText: 'Data de início'),
              readOnly: true,
              onTap: () {
                _openDatePickerInitial(context);
              },
            ),
            const SizedBox(height: 15),
            FormBuilderTextField(
              name: "end_date",
              controller: endDate,
              decoration: const InputDecoration(labelText: 'Data de término'),
              readOnly: true,
              onTap: () {
                _openDatePickerEnd(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _basicInfoStep1() {
    return FormBuilder(
      key: _formKeyStep1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormBuilderDropdown<String>(
            name: 'category',
            initialValue: category.text,
            decoration:
                const InputDecoration(labelText: 'Categoria da competição'),
            items: categories.entries
                .map(
                    (l) => DropdownMenuItem(value: l.key, child: Text(l.value)))
                .toList(),
            onChanged: (v) => setState(() => category.text = v!),
            validator:
                FormBuilderValidators.required(errorText: "Campo obrigatório"),
          ),
          const SizedBox(height: 15),
          FormBuilderDropdown<String>(
            name: 'game_type',
            initialValue: gameType.text,
            items: gameTypes.entries
                .map(
                    (t) => DropdownMenuItem(value: t.key, child: Text(t.value)))
                .toList(),
            onChanged: (v) => setState(() => type.text = v!),
            decoration: const InputDecoration(labelText: 'Tipo de Jogo'),
            validator:
                FormBuilderValidators.required(errorText: "Campo obrigatório"),
          ),
          const SizedBox(height: 15),
          const Text("Tipo de jogadores",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 10),
          FormBuilderRadioGroup<String>(
            name: 'player_type',
            initialValue: playerType.text,
            options: const [
              FormBuilderFieldOption(value: 'male', child: Text('Homens')),
              FormBuilderFieldOption(value: 'female', child: Text('Mulheres')),
            ],
            validator:
                FormBuilderValidators.required(errorText: "Campo obrigatório"),
            onChanged: (value) {
              setState(() {
                playerType.text = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _rulesStep() {
    return FormBuilder(
      key: _formKeyStep2,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            const Text("Critério de desempate",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const SizedBox(height: 10),
            FormBuilderCheckboxGroup<String>(
              name: 'tiebreakers',
              options: tiebreakers
                  .map((item) => FormBuilderFieldOption(
                        value: item.keys.first,
                        child: Text(item.values.first),
                      ))
                  .toList(),
              initialValue: tiebreakersSelected,
              onChanged: (selected) {
                if (selected != null) {
                  setState(() {
                    tiebreakersSelected = selected;
                  });
                }
              },
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.minLength(1,
                    errorText: 'Selecione pelo menos um critério'),
              ]),
            ),
            const SizedBox(height: 15),
            (type.text == 'cup')
                ? Column(
                    children: [
                      FormBuilderSwitch(
                        name: 'penalties',
                        initialValue: isHomeAndAway,
                        title: const Text('Jogo de ida & volta'),
                        onChanged: (value) {
                          setState(() {
                            isHomeAndAway = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 15),
                    ],
                  )
                : const SizedBox.shrink(),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormBuilderDropdown<String>(
                  name: 'points_victory',
                  initialValue: pointsVictory.text,
                  decoration: const InputDecoration(labelText: 'Victória'),
                  items: List.generate(
                    5,
                    (index) => DropdownMenuItem(
                      value: index.toString(),
                      child: Text(index == 0
                          ? '0'
                          : index == 1
                              ? '$index pt'
                              : '$index pts'),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      pointsDraw.text = value!;
                    });
                  },
                  validator: FormBuilderValidators.required(
                      errorText: "Campo obrigatório"),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormBuilderDropdown<String>(
                  name: 'points_draw',
                  initialValue: pointsDraw.text,
                  decoration: const InputDecoration(labelText: 'Empate'),
                  items: List.generate(
                    5,
                    (index) => DropdownMenuItem(
                      value: index.toString(),
                      child: Text(index == 0
                          ? '0'
                          : index == 1
                              ? '$index pt'
                              : '$index pts'),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      pointsDraw.text = value!;
                    });
                  },
                  validator: FormBuilderValidators.required(
                      errorText: "Campo obrigatório"),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormBuilderDropdown<String>(
                  name: 'points_lose',
                  initialValue: pointsLose.text,
                  decoration: const InputDecoration(labelText: 'Derrota'),
                  items: List.generate(
                    5,
                    (index) => DropdownMenuItem(
                      value: index.toString(),
                      child: Text(index == 0
                          ? '0'
                          : index == 1
                              ? '$index pt'
                              : '$index pts'),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      pointsDraw.text = value!;
                    });
                  },
                  validator: FormBuilderValidators.required(
                      errorText: "Campo obrigatório"),
                ),
              ],
            ),
            const SizedBox(height: 15),
            FormBuilderTextField(
                name: 'substitutions_allowed',
                controller: substitutionsAllowed,
                decoration: const InputDecoration(labelText: 'Substituição'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: "Campo obrigatório"),
                  FormBuilderValidators.numeric(
                      errorText: "Penas valor numérico"),
                ])),
            const SizedBox(height: 15),
            // (type.text != 'league' && type.text != 'group_tournament')
            //     ? Column(
            //         children: [
            //           FormBuilderSwitch(
            //             name: 'draws_allowed',
            //             initialValue: drawsAllowed,
            //             onChanged: (value) {
            //               setState(() {
            //                 drawsAllowed = value!;
            //               });
            //             },
            //             title: const Text(
            //               'Permitir Empate',
            //             ),
            //           ),
            //           const SizedBox(height: 15),
            //         ],
            //       )
            //     : const SizedBox.shrink(),
            // (type.text != 'league')
            //     ? Column(
            //         children: [
            //           FormBuilderSwitch(
            //             name: 'extra_time',
            //             initialValue: extraTimeAllowed,
            //             onChanged: (value) {
            //               setState(() {
            //                 extraTimeAllowed = value!;
            //               });
            //             },
            //             title: const Text('Adiciona prolongamento?'),
            //           ),
            //           const SizedBox(height: 15),
            //         ],
            //       )
            //     : const SizedBox.shrink(),

            // FormBuilderSwitch(
            //   name: 'penalty_allowed',
            //   initialValue: penaltyAllowed,
            //   title: const Text('Pênaltis em caso de empate?'),
            //   onChanged: (value) {
            //     setState(() {
            //       penaltyAllowed = value!;
            //     });
            //   },
            // ),

            const SizedBox(height: 15),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: Text("Munutos de jogo",
                      style: const TextStyle(fontSize: 16, color: Colors.grey)),
                ),
                Row(
                  children: [
                    _counterButton("-", () {
                      setState(() {
                        matchDuration = matchDuration - 1;
                      });
                    }),
                    const SizedBox(width: 16),
                    Column(
                      children: [
                        Text('$matchDuration',
                            style: const TextStyle(fontSize: 18)),
                        const Text("min"),
                      ],
                    ),
                    const SizedBox(width: 16),
                    _counterButton("+", () {
                      setState(() {
                        matchDuration = matchDuration + 1;
                      });
                    }),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: Text("Munutos de prolongamento",
                      style: const TextStyle(fontSize: 16, color: Colors.grey)),
                ),
                Row(
                  children: [
                    _counterButton("-", () {
                      setState(() {
                        extraTimeDuration = extraTimeDuration - 1;
                      });
                    }),
                    const SizedBox(width: 16),
                    Column(
                      children: [
                        Text('$extraTimeDuration',
                            style: const TextStyle(fontSize: 18)),
                        const Text("min"),
                      ],
                    ),
                    const SizedBox(width: 16),
                    _counterButton("+", () {
                      setState(() {
                        extraTimeDuration = extraTimeDuration + 1;
                      });
                    }),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: Text("Munutos de Descanso",
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                ),
                Row(
                  children: [
                    _counterButton("-", () {
                      setState(() {
                        restTime = restTime - 1;
                      });
                    }),
                    const SizedBox(width: 16),
                    Column(
                      children: [
                        Text('$restTime', style: const TextStyle(fontSize: 18)),
                        const Text("min"),
                      ],
                    ),
                    const SizedBox(width: 16),
                    _counterButton("+", () {
                      setState(() {
                        restTime = restTime + 1;
                      });
                    }),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),

            const SizedBox(height: 15),
            // const Text("Punições",
            //     style: TextStyle(
            //         fontSize: 14,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.black)),
            // const SizedBox(height: 10),
            // FormBuilderCheckboxGroup(name: 'punishments', options: const [
            //   FormBuilderFieldOption(value: 'Acúmulo de cartões'),
            //   FormBuilderFieldOption(value: 'Suspensões automáticas'),
            //   FormBuilderFieldOption(value: 'Protestos e recursos'),
            // ]),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget _prizesStep() {
    return SingleChildScrollView(
      child: FormBuilder(
        key: _formKeyStep3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Premiações",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const SizedBox(height: 10),
            FormBuilderSwitch(
              name: 'is_for_champion',
              title: const Text('Premiação para o campeão'),
              initialValue: isForChampion,
              onChanged: (value) {
                setState(() {
                  isForChampion = value!;
                });
              },
            ),
            const SizedBox(height: 15),
            (isForChampion)
                ? Column(
                    children: [
                      FormBuilderTextField(
                        name: 'is_for_champion_value',
                        controller: isForChampionValue,
                        decoration: const InputDecoration(hintText: 'Valor'),
                        keyboardType: TextInputType.number,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: "Campo obrigatório"),
                          FormBuilderValidators.numeric(
                              errorText: "Apenas valor numérico")
                        ]),
                      ),
                      const SizedBox(height: 15),
                    ],
                  )
                : const SizedBox.shrink(),
            FormBuilderSwitch(
              name: 'is_for_top_scorer',
              initialValue: isForTopScorer,
              title: const Text('Premiação para artilheiro'),
              onChanged: (value) {
                setState(() {
                  isForTopScorer = value!;
                });
              },
            ),
            const SizedBox(height: 15),
            (isForTopScorer)
                ? Column(
                    children: [
                      FormBuilderTextField(
                        name: 'is_for_top_scorer_value',
                        controller: isForTopScorerValue,
                        decoration: const InputDecoration(hintText: 'Valor'),
                        keyboardType: TextInputType.number,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: "Campo obrigatório"),
                          FormBuilderValidators.numeric(
                              errorText: "Apenas valor numérico")
                        ]),
                      ),
                      const SizedBox(height: 15),
                    ],
                  )
                : const SizedBox.shrink(),
            FormBuilderSwitch(
              name: 'is_for_fair_play',
              title: const Text('Equipe mais disciplinada'),
              initialValue: isForFairPlay,
              onChanged: (value) {
                setState(() {
                  isForFairPlay = value!;
                });
              },
            ),
            const SizedBox(height: 15),
            (isForFairPlay == true)
                ? Column(
                    children: [
                      FormBuilderTextField(
                        name: 'is_for_fair_play_value',
                        decoration: const InputDecoration(hintText: 'Valor'),
                        keyboardType: TextInputType.number,
                        controller: isForFairPlayValue,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: "Campo obrigatório"),
                          FormBuilderValidators.numeric(
                              errorText: "Apenas valor numérico")
                        ]),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String icon, String titulo, String valor) {
    return ListTile(
      leading: SvgPicture.asset(
        icon,
        width: 32,
      ),
      title: Text(
        valor == "" ? "--- ----" : valor,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        titulo,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _boolTile(String icon, String titulo, bool valor) {
    return ListTile(
      leading: SvgPicture.asset(
        icon,
        width: 32,
      ),
      title: Text(titulo),
      trailing: Icon(
        valor ? Icons.check_circle : Icons.cancel,
        color: valor ? Colors.green : Colors.red,
      ),
    );
  }

  Widget _sectionTitle(String titulo) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        titulo,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  String _translateCategory(String value) {
    switch (value) {
      case 'local':
        return 'Local';
      case 'national':
        return 'Nacional';
      case 'international':
        return 'Internacional';
      default:
        return value;
    }
  }

  String _translateTiebreaker(String value) {
    switch (value) {
      case 'goal_difference':
        return 'Diferença de gols';
      case 'goals_scored':
        return 'Gols marcados';
      case 'head_to_head':
        return 'Confronto direto';
      case 'wins':
        return 'Vitórias';
      case 'fair_play':
        return 'Fair play (cartões)';
      case 'random_draw':
        return 'Sorteio';
      default:
        return value;
    }
  }

  String _translatePlayerType(String value) {
    switch (value) {
      case 'male':
        return 'Masculino';
      case 'female':
        return 'Feminino';
      case 'mixed':
        return 'Misto';
      default:
        return value;
    }
  }

  Widget _reviewStep() {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        _sectionTitle('Detalhes da Competição'),
        _infoTile(AppIcons.flag2, 'Nome', name.text),
        _infoTile(AppIcons.calendarColor, 'Temporada', season.text),
        _infoTile(AppIcons.footballJersey, 'Total de Equipes', maxTeams.text),
        _infoTile(AppIcons.locationIndicatorRed, 'Localização', location.text),
        _infoTile(AppIcons.competitionchampion, 'Formato',
            type.text == "league" ? "Liga" : type.text),
        _infoTile(
            AppIcons.category2, 'Categoria', _translateCategory(category.text)),
        _infoTile(AppIcons.ballOfWoolSewing, 'Tipo de Jogo', gameType.text),
        _infoTile(AppIcons.userColor, 'Tipo de Jogador',
            _translatePlayerType(playerType.text)),
        _infoTile(AppIcons.calendarColor, 'Data de Início', startDate.text),
        _infoTile(AppIcons.calendarColor, 'Data de Término', endDate.text),
        _infoTile(AppIcons.calendarColor, 'Data Limite para Inscrição',
            registrationDeadlineDate.text),
        _sectionTitle('Pontuação e Regras'),
        _infoTile(AppIcons.victory, 'Pontos por Vitória', pointsVictory.text),
        _infoTile(AppIcons.minus, 'Pontos por Empate', pointsDraw.text),
        _infoTile(AppIcons.close, 'Pontos por Derrota', pointsLose.text),
        const SizedBox(height: 15),
        const Text("Critérios de desempate"),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: tiebreakersSelected
                  .map((tiebreaker) =>
                      Chip(label: Text(_translateTiebreaker(tiebreaker))))
                  .toList(),
            ),
          ),
        ),
        _infoTile(AppIcons.changeSoccer, 'Substituições Permitidas',
            substitutionsAllowed.text),
        _infoTile(AppIcons.soccerField, 'Máximo de Jogadores', maxPlayers.text),
        _boolTile(AppIcons.minus, 'Permitir Empates', drawsAllowed),
        _boolTile(AppIcons.competitionchampion, 'Permitir Prorrogação',
            extraTimeAllowed),
        _boolTile(AppIcons.soccer, 'Permitir Pênaltis', penaltyAllowed),
        _boolTile(AppIcons.changePosition, 'Ida e Volta', isHomeAndAway),
        (type.text == 'group_tournament')
            ? _infoTile(AppIcons.stopwatch, 'Nº de Grupo', groupQtd.text)
            : const SizedBox.shrink(),
        _infoTile(
            AppIcons.stopwatch, 'Duração da Partida', '$matchDuration min'),
        _infoTile(AppIcons.stopwatch, 'Tempo de Descanso', '$restTime min'),
        _infoTile(AppIcons.stopwatch, 'Duração da Prorrogação',
            '$extraTimeDuration min'),
        _sectionTitle('Premiação'),
        _boolTile(AppIcons.medalChampionAward1, 'Premiação para Campeão',
            isForChampion),
        _infoTile(AppIcons.medalChampionAward1, 'Valor para Campeão',
            'Kz ${isForChampionValue.text}'),
        _boolTile(AppIcons.footballShoesShoe, 'Premiação para Artilheiro',
            isForTopScorer),
        _infoTile(AppIcons.footballShoesShoe, 'Valor para Artilheiro',
            'Kz ${isForTopScorerValue.text}'),
        _boolTile(
            AppIcons.malesFriendsHug, 'Premiação Fair Play', isForFairPlay),
        _infoTile(AppIcons.malesFriendsHug, 'Valor Fair Play',
            'Kz ${isForFairPlayValue.text}'),
      ],
    );
  }

  Widget _counterButton(String symbol, VoidCallback onPressed) {
    return SizedBox(
      width: 40,
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.zero,
        ),
        child: Text(symbol, style: const TextStyle(fontSize: 20)),
      ),
    );
  }

  void _openDatePickerInitial(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime.now().add(const Duration(days: 365 * 2)),
      currentTime: DateTime.now(),
      locale: LocaleType.pt,
      onConfirm: (date) {
        setState(() {
          startDate.text = date.toIso8601String().split('T').first;
        });
      },
    );
  }

  void _openDatePickerEnd(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime.now().add(const Duration(days: 365 * 2)),
      currentTime: DateTime.now(),
      locale: LocaleType.pt,
      onConfirm: (date) {
        setState(() {
          endDate.text = date.toIso8601String().split('T').first;
        });
      },
    );
  }

  void _openDatePickerRegistrationDeadline(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime.now().add(const Duration(days: 365 * 2)),
      currentTime: DateTime.now(),
      locale: LocaleType.pt,
      onConfirm: (date) {
        setState(() {
          registrationDeadlineDate.text =
              date.toIso8601String().split('T').first;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar Competição')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StepProgressIndicator(
              totalSteps: 5,
              currentStep: _currentStep + 1,
              selectedColor: AppColors.primary,
              unselectedColor: Colors.grey[300]!,
            ),
            const SizedBox(height: 16),
            Expanded(child: _buildStep()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentStep > 0)
                  TextButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      onPressed: previousStep,
                      child: const Text('Voltar')),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  onPressed: nextStep,
                  child: Text(_currentStep == 5 ? 'Finalizar' : 'Próximo'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
