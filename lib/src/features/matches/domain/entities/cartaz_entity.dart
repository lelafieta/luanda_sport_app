class CartazEntity {
  final String titulo; // Nome do evento, ex: "Clássico dos Gigantes"
  final String equipeCasa; // Nome do time da casa
  final String equipeVisitante; // Nome do time visitante
  final DateTime dataHora; // Data e hora do jogo
  final String local; // Localização do jogo
  final String imagemEquipeCasa; // Caminho da imagem/logo do time da casa
  final String
      imagemEquipeVisitante; // Caminho da imagem/logo do time visitante
  final String logoCompeticao; // Logo do campeonato
  final String descricao; // Texto extra: chamada, anúncio, etc.

  CartazEntity({
    required this.titulo,
    required this.equipeCasa,
    required this.equipeVisitante,
    required this.dataHora,
    required this.local,
    required this.imagemEquipeCasa,
    required this.imagemEquipeVisitante,
    required this.logoCompeticao,
    required this.descricao,
  });
}
