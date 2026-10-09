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
  double posicaoHorizontalHeroi = 40;
  double posicaoVerticalHeroi = 120;

  // Posição do S1mple Sorrateiro
  double inimigoX = 300.0;
  double inimigoY = 50.0;

  late int _vida;

  bool pocaoColetada = false;
  bool pulando = false;

  int miliss = 200;

  @override
  void initState() {
    super.initState();
    _vida = widget.vida;
  }

  void andarParaDireita() {
    setState(() {
      posicaoHorizontalHeroi += 40;
    });

    checarColisao();
  }

  void andarParaEsquerda() {
    setState(() {
      if (posicaoHorizontalHeroi > 10) {
        posicaoHorizontalHeroi -= 40;
      }
    });

    checarColisao();
  }

  void pular() async {
    if (pulando) return;

    setState(() {
      pulando = true;
      posicaoVerticalHeroi = -180;
    });

    checarColisao();

    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    setState(() {
      posicaoVerticalHeroi = 0;
    });

    checarColisao();

    await Future.delayed(
      const Duration(milliseconds: 200),
    );

    setState(() {
      pulando = false;
    });
  }

  void checarColisao() {
    if (pocaoColetada) return;

    final larguraTela = MediaQuery.of(context).size.width;

    final posicaoPocao = larguraTela - 160;

    bool bateX =
        (posicaoHorizontalHeroi - posicaoPocao).abs() < 90;

    bool bateY = posicaoVerticalHeroi.abs() < 120;

    if (bateX && bateY) {
      setState(() {
        pocaoColetada = true;
        _vida += 25;
      });

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "❤️ Você adquiriu mais 25 de vida!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.grey.shade800,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // FUNDO
          Positioned.fill(
            child: Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTW_ZwRHJk3aaUFdajh1KMxgj8KX2DIWzb27zoUHttINPfqrs8NP3JP8-k&s=10",
              fit: BoxFit.cover,
            ),
          ),

          // POÇÃO
          if (!pocaoColetada)
            Positioned(
              right: 120,
              bottom: 120,
              child: Image.network(
                "https://static.wikia.nocookie.net/minecraft_gamepedia/images/7/75/Water_Bottle_JE2_BE2.png/revision/latest/thumbnail/width/360/height/360?cb=20191027055423",
                height: 80,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.broken_image,
                    size: 60,
                    color: Colors.white,
                  );
                },
              ),
            ),

          // INFORMAÇÕES
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
                    "❤️ Vida: $_vida",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),

                  Text(
                    "💰 Moedas: ${widget.moedas}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),

                  Text(
                    "⚔️ Poder: ${widget.poder}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),

                  Text(
                    "🧠 Inteligência: ${widget.inteligencia}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // PERSONAGEM
          AnimatedPositioned(
            duration: Duration(milliseconds: miliss),
            curve: Curves.easeOut,
            left: posicaoHorizontalHeroi,
            bottom: 120,
            child: Transform.translate(
              offset: Offset(0, posicaoVerticalHeroi),
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
          ),
          Positioned(
            bottom: inimigoY,
            left: inimigoX,
            child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_D3km_H4B58cKV2ebtmEqkGZJsKTL2DcxosTDZIj9id1G7EoyQj-uNazS&s=10',
                   width: 150, height: 130),
          ),

          // BOTÃO ESQUERDA
          Positioned(
            bottom: 30,
            left: 30,
            child: ElevatedButton(
              onPressed: andarParaEsquerda,
              child: const Text(
                "⬅ Esquerda",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),

          // BOTÃO PULAR
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: pulando ? null : pular,
                child: const Text(
                  "⬆ Pular",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),

          // BOTÃO DIREITA
          Positioned(
            bottom: 30,
            right: 30,
            child: ElevatedButton(
              onPressed: andarParaDireita,
              child: const Text(
                "Direita ➡",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
