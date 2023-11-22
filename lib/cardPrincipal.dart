import 'package:clima/icones.dart';
import 'package:flutter/material.dart';

class CardPrincipal extends StatelessWidget {
  final IconeCondicao iconeCondicao;
  final String data;
  final String hora;
  final String temperatura;
  final String descricao;

  const CardPrincipal({
    super.key,
    required this.iconeCondicao,
    required this.data,
    required this.hora,
    required this.temperatura,
    required this.descricao,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                hora,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: iconeCondicao,
                  ),
                  Text(
                    temperatura,
                    style: const TextStyle(
                      fontSize: 64,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                descricao,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                data,
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
