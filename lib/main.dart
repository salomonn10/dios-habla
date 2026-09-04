import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: PantallaPrincipal()));

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});
  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  final controladorNombre = TextEditingController();
  String? cartaActual;
  final random = Random();
  bool grabando = false;
  bool audioGrabado = false;

  void sacarCarta() {
    if (controladorNombre.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Escribe tu nombre primero')));
      return;
    }
    int n = random.nextInt(64) + 1;
    setState(() {
      cartaActual = 'assets/cartas/carta_$n.jpg';
      audioGrabado = true;
      grabando = false;
    });
  }

  void volverAGrabar() {
    setState(() {
      cartaActual = null;
      audioGrabado = false;
      grabando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      appBar: AppBar(
        backgroundColor: Colors.black, 
        centerTitle: true, 
        title: const Text('DIOS ESTA HABLANDO', style: TextStyle(color: Color(0xFFFFE600), fontWeight: FontWeight.w900))
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // 1. NOMBRE ARRIBA DE TODO
            TextField(
              controller: controladorNombre, 
              decoration: InputDecoration(
                hintText: 'Escribe tu nombre aqui', 
                filled: true, 
                fillColor: Colors.white, 
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
              )
            ),
            const SizedBox(height: 15),

            // 2. SI NO HA GRABADO AUDIO, MUESTRA EL GRABADOR
            if (!audioGrabado) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(width: 2)),
                child: Column(
                  children: [
                    Icon(grabando ? Icons.mic : Icons.mic_none, size: 60, color: grabando ? Colors.red : Colors.black),
                    const SizedBox(height: 10),
                    Text(grabando ? "Grabando... di: Soy [tu nombre] Jesus que mensaje tienes para mi Dios en este momento en el nombre de Jesucristo amen" : "Presiona para grabar tu audio", style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                    const SizedBox(height: 15),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (!grabando) {
                          setState(() => grabando = true);
                        } else {
                          // Al detener, saca la carta y borra el grabador
                          sacarCarta();
                        }
                      },
                      icon: Icon(grabando ? Icons.stop : Icons.mic),
                      label: Text(grabando ? "DETENER Y ENVIAR AUDIO" : "🎤 GRABAR AUDIO"),
                      style: ElevatedButton.styleFrom(backgroundColor: grabando ? Colors.red : Colors.black, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Mensajes completos originales
              Container(
                padding: const EdgeInsets.all(12), 
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(12)), 
                child: const Text('GRABA UN AUDIO DICIENDO SOY (TU NOMBRE) JESUS QUE MENSAJE TIENES PARA MI, DIOS EN ESTE MOMENTO EN EL NOMBRE DE JESUCRISTO AMEN.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(10), 
                decoration: BoxDecoration(color: Color(0xFFFFE600), borderRadius: BorderRadius.circular(8)),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
                    Text('EXODO 20:8 ACUÉRDATE DEL SABADO PARA SANTIFICARLO SEIS DIAS TRABAJARAS Y HARAS TODA TU OBRA PERO EL SEPTIMO DIA ES REPOSO DEL SEÑOR TU DIOS', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 11)),
                    SizedBox(height: 6),
                    Text('🟡 AMARILLAS = PROSPERIDAD, DINERO Y RIQUEZA  🔴 ROJAS = AMOR  🟢 VERDES = SALUD  🔵 AZULES = PROTECCION', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  ]
                )
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: sacarCarta, 
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)), 
                child: const Text('ESCUCHAR LO QUE DIOS TIENE PARA MI', style: TextStyle(color: Color(0xFFFFE600), fontWeight: FontWeight.w900))
              ),
            ],

            // 3. CUANDO YA GRABO, SOLO MENSAJE NEGRO + CARTA GIGANTE + VOLVER A GRABAR
            if (audioGrabado && cartaActual != null) ...[
              Container(
                padding: const EdgeInsets.all(12), 
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(12)), 
                child: const Text('GRABA UN AUDIO DICIENDO SOY (TU NOMBRE) JESUS QUE MENSAJE TIENES PARA MI, DIOS EN ESTE MOMENTO EN EL NOMBRE DE JESUCRISTO AMEN.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white, 
                  borderRadius: BorderRadius.circular(15), 
                  border: Border.all(width: 4, color: Colors.black),
                  boxShadow: const [BoxShadow(blurRadius: 10, color: Colors.black26)]
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: Image.asset(cartaActual!, fit: BoxFit.contain),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: volverAGrabar,
                icon: const Icon(Icons.refresh),
                label: const Text("VOLVER A GRABAR AUDIO"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Color(0xFFFFE600), padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}