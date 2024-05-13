import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'global_var.dart';

class ExplicaCaminho extends StatelessWidget {
  const ExplicaCaminho({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalVariables globalVariables = GlobalVariables();
    final Position? posicao = globalVariables.posicao;

    if (posicao == null) {
      return const Text('Esperando pela localização...');
    }

    String blocomsg = '';
    String andarmsg = '';

    if (globalVariables.bloco == 1) {
      blocomsg = 'O destino está no bloco A.';
    } else if (globalVariables.bloco == 2) {
      blocomsg = 'O destino está no bloco B.';
    } else if (globalVariables.bloco == 3) {
      blocomsg = 'O destino está no bloco C.';
    } else if (globalVariables.bloco == 4) {
      blocomsg = 'O destino está no bloco D.';
    } else if (globalVariables.bloco == 5) {
      blocomsg = 'O destino está no bloco E.';
    } else if (globalVariables.bloco == 6) {
      blocomsg = 'O destino está no bloco F.';
    } else if (globalVariables.bloco == 7) {
      blocomsg = 'O destino está no bloco G.';
    } else if (globalVariables.bloco == 8) {
      blocomsg = 'O destino está no bloco J.';
    } else if (globalVariables.bloco == 9) {
      blocomsg = 'O destino está no bloco K.';
    } else if (globalVariables.bloco == 10) {
      blocomsg = 'O destino está no bloco O.';
    } else if (globalVariables.bloco == 11) {
      blocomsg = 'O destino está no bloco L.';
    } else if (globalVariables.bloco == 12) {
      blocomsg = 'O destino está na Quadra.';
    } else if (globalVariables.bloco == 13) {
      blocomsg = 'O destino está na clínica de enfermagem e nutrição.';
    } else if (globalVariables.bloco == 14) {
      blocomsg = 'O destino está entre o bloco K e O.';
    } else {
      blocomsg = 'O destino ainda não foi especificado.';
    }

    if (globalVariables.andar == 1) {
      andarmsg =
          'Você o encontrará no térreo do bloco, se for necessário, utilize a rampa mais próxima.';
    } else if (globalVariables.andar == 2) {
      andarmsg =
          'Você o encontrará no primeiro andar do bloco, se for necessário, utilize a rampa mais próxima.';
    } else if (globalVariables.andar == 3) {
      andarmsg =
          'Você o encontrará no segundo andar do bloco, se for necessário, utilize a rampa mais próxima.';
    } else if (globalVariables.andar == 4) {
      andarmsg =
          'Você o encontrará no terceiro andar do bloco, se for necessário, utilize a rampa mais próxima.';
    } else if (globalVariables.andar == 5) {
      andarmsg =
          'Você pode encontrar em qualquer andar do bloco, verifique o andar correto de sua sala olhando para o primeiro digito do numero da sala (Ex: sala 204 = segundo andar)';
    } else {
      andarmsg = '';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          'EXPLICAÇÃO DO CAMINHO',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  blocomsg,
                  style: const TextStyle(fontSize: 23.0),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  andarmsg,
                  style: const TextStyle(fontSize: 23.0),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Com a ajuda da linha traçada e da bússola em seu mapa, siga em direção à região marcada.',
                  style: TextStyle(fontSize: 23.0),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Acesse as plantas do bloco que quiser apertando as marcações com o nome do bloco em questão e utilizando as setas para chegar ao andar desejado.',
                  style: TextStyle(fontSize: 23.0),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                ),
                child: const Text(
                  'ENTENDI',
                  style: TextStyle(fontSize: 27),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
