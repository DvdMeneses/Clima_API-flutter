import 'package:clima/icones.dart';
import 'package:flutter/material.dart';

class CardDias extends StatelessWidget {
  final IconeCondicao iconeCondicao;
  final String diaDaSemana;
  final String dataAtual;
  final String tempMax;
  final String tempMin;
  final String propabilidadeChuva;

  const CardDias({
    super.key,
    required this.iconeCondicao,
    required this.diaDaSemana,
    required this.dataAtual,
    required this.tempMax,
    required this.tempMin,
    required this.propabilidadeChuva,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${diaDaSemana}. ${dataAtual}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 100,
                  child: iconeCondicao,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${tempMax}°C",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "${tempMin}°C",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Text(
              "Precipitação ${propabilidadeChuva}%",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
