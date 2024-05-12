import 'package:flutter/material.dart';

class Instrucoes extends StatelessWidget {
  const Instrucoes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          'COMO USAR',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Para localizar o bloco de destino, aperte no botão vermelho com o ícone ',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                    WidgetSpan(
                      child: Icon(
                        Icons.navigation,
                        size: 24.0,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: ' ao lado, localizado no canto inferior da tela.',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'No menu de navegação, é possível utilizar os botoes ',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                    WidgetSpan(
                      child: Icon(
                        Icons.restart_alt_rounded,
                        size: 24.0,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: ' e ',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                    WidgetSpan(
                      child: Icon(
                        Icons.info,
                        size: 24.0,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text:
                          ' para respectivamente apagar o caminho e obter informações do bloco e do andar em que o destino está.',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Dentro do menu de informações anterior, existe o botão ',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                    WidgetSpan(
                      child: Icon(
                        Icons.add,
                        size: 24.0,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text:
                          ' que dará informações mais detalhadas sobre o caminho ',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text:
                      'Obtenha mais informações sobre o bloco acessando as plantas, apertando em cima do nome dos blocos na tela do mapa.',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical:
                        20),
                  ),
                  child: const Text('ENTENDI',
                    style: TextStyle(
                        fontSize:
                        27),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}