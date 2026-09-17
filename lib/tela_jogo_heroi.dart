import 'package:flutter/material.dart';
import 'tela_gameplay.dart' hide Navigator;

class TelaJogoHeroi extends StatefulWidget {
  const TelaJogoHeroi({super.key});

  @override
  State<TelaJogoHeroi> createState() => TelaJogoHeroiState();
}

class TelaJogoHeroiState extends State<TelaJogoHeroi> {
  String nomeHeroi = "";
  String titulo = "";
  String classe = "";

  int vida = 0;
  int moedas = 0;
  int poder = 0;
  int inteligencia = 0;

  String urlImagem = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Jogo dos Heróis")),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Selecione seu Herói",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              // BOTÕES DOS HERÓIS
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      escolhaHeroi("Professor");
                    },
                    child: const Text("Professor"),
                  ),

                  const SizedBox(width: 10),

                  ElevatedButton(
                    onPressed: () {
                      escolhaHeroi("Friozera");
                    },
                    child: const Text("Friozera"),
                  ),

                  const SizedBox(width: 10),

                  ElevatedButton(
                    onPressed: () {
                      escolhaHeroi("DeusPesado");
                    },
                    child: const Text("DeusPesado"),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // IMAGEM DO HERÓI
              if (urlImagem.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    urlImagem,
                    width: 200,
                    height: 250,
                    fit: BoxFit.cover,

                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image, size: 100);
                    },
                  ),
                ),

              const SizedBox(height: 20),

              // INFORMAÇÕES DO HERÓI
              if (nomeHeroi.isNotEmpty)
                Card(
                  elevation: 5,
                  color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(20),

                    child: Column(
                      children: [
                        // NOME
                        Text(
                          "Nome: $nomeHeroi",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // TÍTULO
                        Text(
                          "Título: $titulo",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // CLASSE
                        Text(
                          "Classe: $classe",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const Divider(),

                        // VIDA
                        Text(
                          "❤️ Vida: $vida",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                          ),
                        ),

                        // MOEDAS
                        Text(
                          "💰 Moedas: $moedas",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.orange,
                          ),
                        ),

                        // PODER
                        Text(
                          "⚔️ Poder: $poder",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        ),

                        // INTELIGÊNCIA
                        Text(
                          "🧠 Inteligência: $inteligencia",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 51, 255, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              // BOTÃO SELECIONAR
              ElevatedButton(
                onPressed: nomeHeroi.isEmpty
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TelaDeGameplay(
                              heroi: nomeHeroi,
                              imagem: urlImagem,
                              vida: vida,
                              moedas: moedas,
                              poder: poder,
                              inteligencia: inteligencia,
                            ),
                          ),
                        );
                      },
                child: const Text("Selecionar", style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // FUNÇÃO PARA ESCOLHER O HERÓI
  void escolhaHeroi(String tipoHeroi) {
    setState(() {
      if (tipoHeroi == "Professor") {
        classe = "Professor";
        nomeHeroi = "Gabriel " "'FalleN'" " Toledo de Alcântara Sguario";
        titulo = "O Professor";

        vida = 2000;
        moedas = 1000;
        poder = 999999;
        inteligencia = 5000000;

        urlImagem =
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEDhDwart9I8IjvoGDhdnoYRoBwbRNGy494TxcK-hvjg&s";
      } else if (tipoHeroi == "Friozera") {
        classe = "Gelado";
        nomeHeroi = "Marcelo" " 'Coldzera'" " David";
        titulo = "The Brazilian Terminator";

        vida = 1000;
        moedas = 100;
        poder = 1000000;
        inteligencia = 1000000;

        urlImagem =
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAbrk_2kboawxahxigoLVrOfkpN8mqAnbPIiGY4ymoYw&s";
      } else if (tipoHeroi == "DeusPesado") {
        classe = "Pesado";
        nomeHeroi = "Nikita" " 'HeavyGod'" " Martynenko";
        titulo = "Buger King";

        vida = 13;
        moedas = 1000;
        poder = 0;
        inteligencia = 1;

        urlImagem =
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxf-fgPtT-SGe5WomZa4gQESpGboMr--PvJf3qkIYnOg&s=10";
      }
    });
  }
}