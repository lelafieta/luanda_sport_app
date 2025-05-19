import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import '../../../../core/resources/app_images.dart';
import '../../domain/entities/team_entity.dart';
import '../cubit/team_action_cubit/team_action_cubit.dart';
import 'build_equipament_page.dart';

class CreateTeamPage extends StatefulWidget {
  const CreateTeamPage({super.key});

  @override
  State<CreateTeamPage> createState() => _CreateTeamPageState();
}

class _CreateTeamPageState extends State<CreateTeamPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final ValueNotifier<File?> imageFile = ValueNotifier<File?>(null);
  final ImagePicker picker = ImagePicker();

  final Map<String, String> typeToImage = {
    'main': AppImages.typeEmpty,
    'type1': AppImages.type1,
    'type2': AppImages.type2,
    'type3': AppImages.type3,
    'type4': AppImages.type4,
    'type5': AppImages.type5,
    'type6': AppImages.type6,
    'type7': AppImages.type7,
    'type8': AppImages.type8,
    'type9': AppImages.type9,
    'type10': AppImages.type10,
    'type11': AppImages.type11,
    'type12': AppImages.type12,
    'type13': AppImages.type13,
    'type14': AppImages.type14,
    'type15': AppImages.type15,
    'type16': AppImages.type16,
    'type17': AppImages.type17,
  };

  // final Map<String, String> typeToImage = {
  //   'main': 'Main',
  //   'type1': 'Type 1',
  //   'type2': 'Type 2',
  //   'type3': 'Type 3',
  //   'type4': 'Type 4',
  //   'type5': 'Type 5',
  //   'type6': 'Type 6',
  //   'type7': 'Type 7',
  //   'type8': 'Type 8',
  //   'type9': 'Type 9',
  //   'type10': 'Type 10',
  //   'type11': 'Type 11',
  //   'type12': 'Type 12',
  //   'type13': 'Type 13',
  //   'type14': 'Type 14',
  //   'type15': 'Type 15',
  //   'type16': 'Type 16',
  //   'type17': 'Type 17',
  // };

  Map<String, String> teamData = {};

  Future<void> _openSelectionPage(Map<String, String> teamData) async {
    Map<String, String> result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BuildEquipamentPage(teamData: teamData),
      ),
    );

    setState(() {
      teamData = result;
    });
  }

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile.value = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    teamData = {
      'equipament_number_color': 'Color(0xffffffff)',
      'equipament_main_color': 'Color(0xff000000)',
      'equipament_type_color': 'Color(0xffffffff)',
      'equipament_type': 'main'
    };
  }

  Color parseColorFromString(String colorString) {
    // Remove a parte "Color(" e ")"
    final hexString = colorString.replaceAll(RegExp(r'[^0-9a-fA-F]'), '');

    // Converte a string hexadecimal para inteiro
    return Color(int.parse('0xff$hexString'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.bg2),
          opacity: .2,
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Cadastrar Equipe"),
          backgroundColor: AppColors.primary,
        ),
        body: BlocListener<TeamActionCubit, TeamActionState>(
          listener: (context, state) {
            EasyLoading.dismiss();
            if (state is TeamActionLoading) {
              EasyLoading.show();
            }
            if (state is TeamActionFailure) {
              EasyLoading.showError("Ouve um erro ${state.error}");
            } else if (state is TeamActionSuccess) {
              EasyLoading.showSuccess("Equipe criada com sucesso.");
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: FormBuilder(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'name',
                      decoration:
                          const InputDecoration(labelText: 'Nome da Equipe'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Nome é obrigatório'),
                        FormBuilderValidators.minLength(3,
                            errorText: 'Mínimo 3 caracteres'),
                      ]),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "EQUIPAMENTO / LOGOTIPO",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    // Get.to(BuildEquipamentPage());
                                    _openSelectionPage(teamData);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    width: MediaQuery.sizeOf(
                                                            context)
                                                        .width,
                                                    child: Image.asset(
                                                        AppImages.mainTShirt,
                                                        width: 20,
                                                        color: parseColorFromString(
                                                            teamData[
                                                                'equipament_main_color']!)
                                                        //     as Color,
                                                        ),
                                                  ),
                                                  Positioned.fill(
                                                    child: Image.asset(
                                                      AppImages.body,
                                                      width: 20,
                                                      color: (parseColorFromString(
                                                                      teamData[
                                                                          'equipament_main_color']!) ==
                                                                  Colors
                                                                      .black ||
                                                              parseColorFromString(
                                                                      teamData[
                                                                          'equipament_main_color']!) ==
                                                                  Colors.black)
                                                          ? Colors.white12
                                                          : Colors.black12,
                                                      //     as Color,
                                                    ),
                                                  ),
                                                  Positioned.fill(
                                                      left: 0,
                                                      right: 0,
                                                      top: 0,
                                                      child: Image.asset(
                                                        typeToImage[teamData[
                                                            'equipament_type']]!,
                                                        color: parseColorFromString(
                                                            teamData[
                                                                'equipament_type_color']!),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                // color: Colors.black,
                                                child: Stack(
                                                  children: [
                                                    Image.asset(
                                                        AppImages
                                                            .backPartTShirt,
                                                        color: parseColorFromString(
                                                            teamData[
                                                                'equipament_main_color']!)),
                                                    Positioned.fill(
                                                      child: Center(
                                                        child: Text(
                                                          "7",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            color: parseColorFromString(
                                                                teamData[
                                                                    'equipament_number_color']!),
                                                            fontSize: 25,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned.fill(
                                                      child: Image.asset(
                                                        AppImages.bodyBack,
                                                        width: 20,
                                                        color: (parseColorFromString(
                                                                        teamData[
                                                                            'equipament_main_color']!) ==
                                                                    Colors
                                                                        .black ||
                                                                parseColorFromString(
                                                                        teamData[
                                                                            'equipament_main_color']!) ==
                                                                    Colors
                                                                        .black)
                                                            ? Colors.white12
                                                            : Colors.black12,
                                                        //     as Color,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            // const Text("Equipamento")
                                          ],
                                        ),
                                        const Text("Equipamentos")
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    pickImage();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: (imageFile.value != null)
                                                  ? ValueListenableBuilder<
                                                      File?>(
                                                      valueListenable:
                                                          imageFile,
                                                      builder:
                                                          (context, file, _) {
                                                        if (file == null) {
                                                          return const SizedBox
                                                              .shrink();
                                                        } else {
                                                          return Image.file(
                                                            file,
                                                            width: 55,
                                                            height: 55,
                                                            fit: BoxFit.contain,
                                                          );
                                                        }
                                                      },
                                                    )
                                                  : SvgPicture.asset(
                                                      width: 55,
                                                      AppIcons.security,
                                                    ),
                                            ),

                                            // const Text("Equipamento")
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text("Logotipo")
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    FormBuilderTextField(
                      name: 'category',
                      decoration: const InputDecoration(
                          labelText: 'Categoria/Modalidade'),
                      validator: FormBuilderValidators.required(
                          errorText: 'Categoria é obrigatória'),
                    ),
                    const SizedBox(height: 15),
                    FormBuilderTextField(
                      name: 'location',
                      decoration:
                          const InputDecoration(labelText: 'Localização'),
                      validator: FormBuilderValidators.required(
                          errorText: 'Localização é obrigatória'),
                    ),
                    const SizedBox(height: 15),
                    FormBuilderTextField(
                      name: 'captain_name',
                      decoration:
                          const InputDecoration(labelText: 'Nome do Capitão'),
                      validator: FormBuilderValidators.required(
                          errorText: 'Nome do capitão é obrigatório'),
                    ),
                    const SizedBox(height: 15),
                    FormBuilderTextField(
                      name: 'captain_contact',
                      decoration: const InputDecoration(
                          labelText: 'Contato do Capitão'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Contato é obrigatório'),
                        FormBuilderValidators.numeric(
                            errorText: 'Somente números'),
                      ]),
                    ),
                    const SizedBox(height: 15),
                    FormBuilderDropdown(
                      name: 'equipment_type',
                      decoration: const InputDecoration(
                          labelText: 'Tipo de Equipamento'),
                      items: typeToImage.entries
                          .map((e) => DropdownMenuItem(
                              value: e.key, child: Text(e.value)))
                          .toList(),
                      validator: FormBuilderValidators.required(
                          errorText: 'Selecione um tipo'),
                    ),
                    const SizedBox(height: 15),
                    FormBuilderDateTimePicker(
                      name: 'founded_at',
                      inputType: InputType.date,
                      decoration:
                          const InputDecoration(labelText: 'Data de Fundação'),
                    ),
                    const SizedBox(height: 15),
                    FormBuilderTextField(
                      name: 'invite_code',
                      decoration:
                          const InputDecoration(labelText: 'Código de Convite'),
                    ),
                    const SizedBox(height: 15),
                    FormBuilderTextField(
                      name: 'member_limit',
                      decoration: const InputDecoration(
                          labelText: 'Número máximo de integrantes'),
                      keyboardType: TextInputType.number,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Informe o número máximo'),
                        FormBuilderValidators.integer(
                            errorText: 'Deve ser um número inteiro'),
                        FormBuilderValidators.min(1,
                            errorText: 'Mínimo 1 integrante'),
                      ]),
                    ),
                    const SizedBox(height: 15),
                    FormBuilderTextField(
                      name: 'description',
                      decoration:
                          const InputDecoration(helperText: 'Descrição'),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 15),
                    FormBuilderDropdown(
                      name: 'status',
                      decoration: const InputDecoration(labelText: 'Status'),
                      initialValue: 'pending',
                      items: const [
                        DropdownMenuItem(
                            value: 'pending', child: Text('Pendente')),
                        DropdownMenuItem(
                            value: 'approved', child: Text('Aprovado')),
                        DropdownMenuItem(
                            value: 'rejected', child: Text('Rejeitado')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              // if (_formKey.currentState?.saveAndValidate() ?? false) {
              //   final data = _formKey.currentState?.value;
              //   print("Formulário válido: $data");
              //   // TODO: enviar para o Supabase
              // } else {
              //   print("Formulário inválido");
              // }

              final team = TeamEntity(
                id: const Uuid().v4(),
                name: 'Estrelas do Amanhã',
                logoUrl: 'https://meusite.com/imagens/estrelas_logo.png',
                description:
                    'Time juvenil focado em desenvolver novos talentos.',
                category: 'Sub-17',
                location: 'Luanda, Angola',
                captainName: 'João Pedro',
                captainContact: '+244923456789',
                memberLimit: 25,
                foundedAt: DateTime(2015, 9, 12),
                inviteCode: 'ESTRELA2025',
                socialLinks: {
                  'instagram': 'https://instagram.com/estrelasfc',
                  'facebook': 'https://facebook.com/estrelasfc',
                },
                status: 'pending',
                createdBy: 'user_abc123',
                createdAt: DateTime.now(),
                equipmentType: 'type1',
                abbreviation: 'EAM',
              );

              BlocProvider.of<TeamActionCubit>(context).createTeam(team);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(fontSize: 16),
            ),
            child: const Text("Criar Equipe"),
          ),
        ),
      ),
    );
  }
}
