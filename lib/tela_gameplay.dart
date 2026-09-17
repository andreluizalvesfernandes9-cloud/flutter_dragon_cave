import 'package:flutter/material.dart';

class TelaDeGameplay extends StatefulWidget {
  final String heroi;
  final String imagem;
  final int vida;
  final int moedas;
  final int poder;
  final int inteligencia;

  const TelaDeGameplay({
    super.key,
    required this.heroi,
    required this.imagem,
    required this.vida,
    required this.moedas,
    required this.poder,
    required this.inteligencia,
  });

  @override
  State<TelaDeGameplay> createState() => _TelaDeGameplayState();
}

class _TelaDeGameplayState extends State<TelaDeGameplay> {
  double posicaoHorizontal = 40;
  int miliss = 200;

  void andarParaDireita() {
    setState(() {
      posicaoHorizontal += 40;
    });
  }

  void andarParaEsquerda() {
    setState(() {
      if (posicaoHorizontal > 10) {
        posicaoHorizontal -= 40;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // FUNDO
          Positioned.fill(
            child: Image.asset(
              "https://wallup.net/abstracto-bosque-fantasia-ruina-ciudad/",
              fit: BoxFit.cover,
            ),
          ),

          // INFORMAÇÕES DO HERÓI
          Positioned(
            top: 40,
            left: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.heroi,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "❤️ Vida: ${widget.vida}",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),

                  Text(
                    "💰 Moedas: ${widget.moedas}",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),

                  Text(
                    "⚔️ Poder: ${widget.poder}",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),

                  Text(
                    "🧠 Inteligência: ${widget.inteligencia}",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),

          // PERSONAGEM
          AnimatedPositioned(
            duration: Duration(milliseconds: miliss),
            curve: Curves.bounceIn,
            left: posicaoHorizontal,
            bottom: 120,
            child: Image.network(
              widget.imagem,
              height: 130,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.broken_image,
                  size: 100,
                  color: Colors.white,
                );
              },
            ),
          ),

          // BOTÃO ESQUERDA
          Positioned(
            bottom: 30,
            left: 30,
            child: ElevatedButton(
              onPressed: andarParaEsquerda,
              child: const Text("⬅ Esquerda", style: TextStyle(fontSize: 18)),
            ),
          ),

          // BOTÃO DIREITA
          Positioned(
            bottom: 30,
            right: 30,
            child: ElevatedButton(
              onPressed: andarParaDireita,
              child: const Text("Direita ➡", style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}