import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String? title;
  final String? description;
  const EmptyWidget({super.key, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        border: Border.all(width: 1, color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          Icons.warning,
          color: Colors.orange,
          size: 32,
        ),
        title: Text(
          "Para teres estatisticas primeiramente tens que estar associado a uma equipe.",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.grey.shade700,
          ),
        ),
        // subtitle: Text("Lorem ipson"),
      ),
    );
  }
}
