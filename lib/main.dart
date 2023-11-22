import 'dart:io';
import 'package:clima/icones.dart';
import 'package:clima/cardPrincipal.dart';
import 'package:clima/cardDias.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const HomeMaterial(),
    );
  }
}

class HomeMaterial extends StatefulWidget {
  const HomeMaterial({super.key});

  @override
  State<HomeMaterial> createState() => _HomeMaterialState();
}

class _HomeMaterialState extends State<HomeMaterial> {
  late Future<Map<String, dynamic>> dadosCotacoes;

  @override
  void initState() {
    super.initState();
    dadosCotacoes = getDadosCotacoes('Natal');
  }

  Future<Map<String, dynamic>> getDadosCidadeInicial() async {
    try {
      final res = await http.get(
        Uri.parse(
          'https://api.hgbrasil.com/weather?key={SUAKEY}&user_ip=remote',
        ),
      );

      if (res.statusCode != HttpStatus.ok) {
        throw 'Erro de conexão';
      }

      final data = jsonDecode(res.body);

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Map<String, dynamic>> getDadosCotacoes(String cidade) async {
    try {
      final res = await http.get(
        Uri.parse(
          'https://api.hgbrasil.com/weather?key={SUAKEY}&city_name=${cidade}',
        ),
      );

      if (res.statusCode != HttpStatus.ok) {
        throw 'Erro de conexão';
      }

      final data = jsonDecode(res.body);

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController inputController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: double.maxFinite,
          height: 40,
          child: TextField(
            controller: inputController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              hintText: 'Pesquisar...',
              hintStyle: const TextStyle(
                color: Color.fromARGB(68, 255, 255, 255),
                fontSize: 13,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                dadosCotacoes = getDadosCotacoes(inputController.text);
              });
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: FutureBuilder(
          future: dadosCotacoes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            final data = snapshot.data!;

            final dadosDaCidade = data['results'];
            final listaSeteDias = data['results']['forecast'];

            listaSeteDias.removeAt(0);
            listaSeteDias.removeAt(listaSeteDias.length - 1);
            listaSeteDias.removeAt(listaSeteDias.length - 1);
            print(listaSeteDias);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(dadosDaCidade['city'], style: TextStyle(fontSize: 24)),
                  CardPrincipal(
                    iconeCondicao: IconeCondicao(
                        condicao: dadosDaCidade['condition_slug']),
                    hora: dadosDaCidade['time'],
                    data: dadosDaCidade['date'],
                    temperatura: "${dadosDaCidade['temp']}º",
                    descricao: dadosDaCidade['description'],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 220.0),
                    child: Text(
                      "PREVISÃO DE 7 DIAS",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 184,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: listaSeteDias.length,
                      itemBuilder: (context, index) {
                        return CardDias(
                          iconeCondicao: IconeCondicao(
                              condicao: listaSeteDias[index]['condition']),
                          diaDaSemana: listaSeteDias[index]['weekday'],
                          dataAtual: listaSeteDias[index]['date'],
                          tempMax: "${listaSeteDias[index]['max']}",
                          tempMin: "${listaSeteDias[index]['min']}",
                          propabilidadeChuva:
                              "${listaSeteDias[index]['rain_probability']}",
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
/*

body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // main card
            CardMoeda(
                nomeMoeda: 'Euro',
                valorMoeda: 'R\$5,1',
                variacaoMoeda: '+10,00'
              ),
            SizedBox(height: 20),
            Text(
              'Outras moedas',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CardMoedaItem(
                    nomeMoeda: 'Dollar',
                    valorMoeda: 'R\$4.999',
                    variacaoMoeda: '+2,00',
                  ),
*/
