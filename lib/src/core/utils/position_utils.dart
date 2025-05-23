class PositionUtils {
  static String covertPosition(String position) {
    switch (position) {
      case 'Goalkeeper':
        return 'Guarda-redes';
      case 'Center Back':
        return 'Defesa Central';
      case 'Right Back':
        return 'Lateral Direito';
      case 'Left Back':
        return 'Lateral Esquerdo';
      case 'Midfielder':
        return 'Médio';
      case 'Forward':
        return 'Avançado';
      default:
        return 'Desconhecido';
    }
  }
}
