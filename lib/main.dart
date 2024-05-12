import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:async';
import 'global_var.dart';
import 'tela_instrucoes.dart';
import 'explica_caminho.dart';
import 'c_mostar_imagem.dart';
import 'tela_creditos.dart';
import 'package:geodesy/geodesy.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SAGRADOMaps',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'SAGRADOMaps'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

GlobalVariables globalVariables = GlobalVariables();

class _MyHomePageState extends State<MyHomePage> {
  Timer? timer;

  String blocoAtual = '';
  bool noQuadrant = false;

  List<LatLng> userLoc = [];
  List<LatLng> interpointIni = [];
  List<LatLng> interpointFinal = [];

  List<LatLng> polylinePoints = [];

  double shortestDistance = double.infinity;
  LatLng? closestCoordinate;

  double? heading = 0;

  void processLatLngList(List<LatLng> userLocations, List<LatLng> interpointIni,
      List<LatLng> interpointFinal, List<LatLng> finalLocations) {
    polylinePoints.clear();
    polylinePoints.addAll(userLocations);
    polylinePoints.addAll(interpointIni);
    polylinePoints.addAll(interpointFinal);
    polylinePoints.addAll(finalLocations);
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _getCurrentLocation();
    });
    FlutterCompass.events!.listen((event) {
      setState(() {
        heading = event.heading;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  void _getCurrentLocation() async {
    GlobalVariables globalVariables = GlobalVariables();
    Position position = await _determinePosition();
    setState(() {
      globalVariables.posicao = position;
      if (globalVariables.posicao != null) {
        if (userLoc.isNotEmpty) {
          // Se a lista já tiver pontos, substitui apenas o último ponto pelo novo
          userLoc[userLoc.length - 1] = LatLng(
              globalVariables.posicao!.latitude,
              globalVariables.posicao!.longitude);
        } else {
          // Se a lista estiver vazia, adiciona o novo ponto à lista
          userLoc.add(LatLng(globalVariables.posicao!.latitude,
              globalVariables.posicao!.longitude));
        }
      }
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permissões para localizão estão negadas');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  final Map<String, List<LatLng>> blocoQuadrantes = {
    'Blocos A e B': [
      const LatLng(-22.328054, -49.053069),
      const LatLng(-22.327741, -49.051863),
      const LatLng(-22.328089, -49.051759),
      const LatLng(-22.328407, -49.052930),
    ],
    'Blocos C, D e E': [
      const LatLng(-22.328089, -49.051759),
      const LatLng(-22.328407, -49.052930),
      const LatLng(-22.328848, -49.052849),
      const LatLng(-22.328536, -49.051598),
    ],
    'Blocos F e G': [
      const LatLng(-22.328848, -49.052849),
      const LatLng(-22.328536, -49.051598),
      const LatLng(-22.328928, -49.051485),
      const LatLng(-22.329225, -49.052688),
    ],
    'Bloco J': [
      const LatLng(-22.329692, -49.051190),
      const LatLng(-22.330059, -49.052495),
      const LatLng(-22.330377, -49.052388),
      const LatLng(-22.330064, -49.051115),
    ],
    'Bloco K': [
      const LatLng(-22.330377, -49.052388),
      const LatLng(-22.330064, -49.051115),
      const LatLng(-22.330473, -49.050993),
      const LatLng(-22.330830, -49.052217),
    ],
    'Bloco O': [
      const LatLng(-22.330545, -49.050890),
      const LatLng(-22.330858, -49.052211),
      const LatLng(-22.331558, -49.051964),
      const LatLng(-22.331255, -49.050719),
    ],
    'Bloco L': [
      const LatLng(-22.331404, -49.050777),
      const LatLng(-22.331623, -49.051700),
      const LatLng(-22.332034, -49.051610),
      const LatLng(-22.331817, -49.050642),
    ],
    'Quadra': [
      const LatLng(-22.331817, -49.050642),
      const LatLng(-22.332034, -49.051610),
      const LatLng(-22.332371, -49.051502),
      const LatLng(-22.332158, -49.050506),
    ],
    'Enf': [
      const LatLng(-22.328938, -49.053096),
      const LatLng(-22.329052, -49.053439),
      const LatLng(-22.330294, -49.053074),
      const LatLng(-22.330185, -49.052704),
    ],
  };

  List<String> locais = [
    /*0 BLOCO G TERRERO*/
    'Área da Saúde',
    /*1 BLOCO F TERRERO*/
    'Área Exatas',
    /*2 BLOCO F TERRERO*/
    'Área Humanas',
    /*3 BLOCO F TERRERO*/
    'Áreas Sociais',
    /*4 BLOCO E TERRERO*/
    'Anfiteatro E001',
    /*5 BLOCO F TERRERO*/
    'Anfiteatro E002',
    /*6 BLOCO L TERRERO*/
    'Anfiteatros L',
    /*7 BLOCO O TERRERO*/
    'Anfiteatros O',
    /*8 BLOCO J PISO 1*/
    'Auditório Cléia Merloni',
    /*9 BLOCO J PISO 1*/
    'Auditório João Paulo II',
    /*10 BLOCO A TERREO*/
    'Biblioteca',
    /*11 BLOCO C PISO 1*/
    'Brinquedoteca',
    /*12 BLOCO G TERREO*/
    'Capela',
    /*13 BLOCO G TERREO*/
    'Central de Eventos/Coordenadoria de Extensão/Coordenadoria Pedagógica/Comunicação/Pós Graduação e Iniciação Cientifica',
    /*14 BLOCO K PISO 1*/
    'Clínica de Fisioterapia',
    /*15 ATRAVESSA A RUA*/
    'Clínica de Nutrição & Lab de Enfermagem',
    /*16 BLOCO O TERREO*/
    'Clínica de Odontologia',
    /*17 BLOCO K PISO 1*/
    'Clínica de Psicologia',
    /*18 BLOCO B TERREO*/
    'Financeiro',
    /*19 BLOCO C TERREO*/
    'Lab de Anatomia',
    /*20 BLOCO D TERREO*/
    'Lab de Análise de Medicamentos',
    /*21 BLOCO E TERREO*/
    'Lab de Biociências',
    /*22 BLOCO K PISO 1*/
    'Lab de Criação em Vestuários',
    /*23 BLOCO K PISO 3*/
    'Lab de Estética e Cosmética',
    /*24 BLOCO J TERREO*/
    'Lab de Gastronomia',
    /*25 BLOCO J PISO 3*/
    'Lab de Modelos e Maquetes',
    /*26 BLOCO C TERREO*/
    'Lab de Nutrição',
    /*27 BLOCO O TERREO*/
    'Lab de Operações Unitárias',
    /*28 BLOCO J PISO 1*/
    'Lab de Projetos',
    /*29 BLOCO C TERREO*/
    'Lab de Química',
    /*30 BLOCO E TERREO*/
    'Lab de Tecnologia Farmacêutica',
    /*31 BLOCO L TERREO*/
    'Lab Engenharias',
    /*32 BLOCO K PISO 1*/
    'Lab Multidisciplinar',
    /*33 BLOCO K PISO 2*/
    'Lab Zoobotânico',
    /*34 BLOCO F T E P1*/
    'Labs de Informática',
    /*35 BLOCO C TERREO*/
    'Lanchonete',
    /*36 BLOCO J PISO 1*/
    'NEPRI',
    /*37 BLOCO K TERREO*/
    'NUPHIS',
    /*38 BLOCO J PISO 3*/
    'Núcleo de Produção Multimídia',
    /*39 BLOCO F TERREO*/
    'Pastoral',
    /*40 BLOCO B PISO 1*/
    'Pró Reitoria Administrativa',
    /*41 QUADRA*/
    'Quadra Poliesportiva',
    /*42 BLOCO B PISO 1*/
    'Recursos Humanos',
    /*43 BLOCO A PISO 1*/
    'Reitoria',
    /*44 BLOCO J TERREO*/
    'Restaurante Universitária',
    /*45 BLOCO C PISO 1*/
    'Sala de aula Bloco C - Final Impar',
    /*46 BLOCO C PISO 1*/
    'Sala de aula Bloco C - Final Par',
    /*47 BLOCO D PISO 1*/
    'Sala de aula Bloco D - Final Impar',
    /*48 BLOCO D PISO 1*/
    'Sala de aula Bloco D - Final Par',
    /*49 BLOCO E PISO 1*/
    'Sala de aula Bloco E - Final Impar',
    /*50 BLOCO E PISO 1*/
    'Sala de aula Bloco E- Final Par',
    /*51 BLOCO F PISO 1*/
    'Sala de aula Bloco F - Final Impar',
    /*52 BLOCO F PISO 1*/
    'Sala de aula Bloco F - Final Par',
    /*53 BLOCO G PISO 1*/
    'Sala de aula Bloco G - Final Impar',
    /*54 BLOCO G PISO 1*/
    'Sala de aula Bloco G - Final Par',
    /*55 BLOCO J PISO 1 2 3*/
    'Sala de aula Bloco J - Final Impar',
    /*56 BLOCO J PISO 1 2 3*/
    'Sala de aula Bloco J - Final Par',
    /*57 BLOCO K PISO 1 2 3*/
    'Sala de aula Bloco K - Final Impar',
    /*58 BLOCO K PISO 1 2 3*/
    'Sala de aula Bloco K - Final Par',
    /*59 BLOCO O PISO 1*/
    'Sala de aula Bloco O - Final Impar',
    /*60 BLOCO O PISO 1*/
    'Sala de aula Bloco O - Final Par',
    /*61 BLOCO L PISO 1*/
    'Sala de aula Bloco L - Final Impar',
    /*62 BLOCO L PISO 1*/
    'Sala de aula Bloco L - Final Par',
    /*63 BLOCO E T E P1*/
    'Salas Metodologias Ativas',
    /*64 BLOCO B TERREO*/
    'Secretaria Acadêmica',
    /*65 ENTRE K E O*/
    'Setor de Compras',
    /*66 BLOCO B TERREO*/
    'UATI',
    /*67 BLOCO C TERREO*/
    'UNISAGRADO STORE'
  ];

  @override
  Widget build(BuildContext context) {
    LatLngBounds limite = LatLngBounds(
      const LatLng(-22.3341229, -49.0539937), // sudoeste
      const LatLng(-22.32602719, -49.04954767), // nordeste
    );

    GlobalVariables globalVariables = GlobalVariables();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Center(
                child: Text(
                  'OPÇÕES',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Como usar',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Instrucoes()),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Créditos',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Creditos()),
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: const LatLng(-22.32948788, -49.05182004),
              initialZoom: 17.4,
              maxBounds: limite,
              interactiveFlags:
                  InteractiveFlag.pinchZoom | InteractiveFlag.drag,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              //#region Marcação User
              if (globalVariables.posicao != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80,
                      height: 80,
                      point: LatLng(
                        globalVariables.posicao!.latitude,
                        globalVariables.posicao!.longitude,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Fluttertoast.showToast(
                            msg: 'Você está aqui!',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black.withOpacity(0.5),
                          );
                        },
                        child: const Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              //#endregion
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: polylinePoints,
                    color: Colors.red,
                    strokeWidth: 3.0,
                  ),
                ],
              ),
              //#region Marcação labels
              MarkerLayer(
                markers: [
                  Marker(
                    width: 65,
                    height: 50,
                    point: const LatLng(-22.3280, -49.0524),
                    child: GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (_) => const AeBTerreo());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          'BLOCOS A & B',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: const LatLng(-22.3285, -49.0523),
                    width: 65,
                    height: 50,
                    child: GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context, builder: (_) => CDETerreo());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          'BLOCOS C, D & E',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: const LatLng(-22.3289, -49.0521),
                    width: 65,
                    height: 50,
                    child: GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context, builder: (_) => FeGTerreo());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          'BLOCOS F & G',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: const LatLng(-22.3302, -49.0517),
                    width: 65,
                    height: 50,
                    child: GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context, builder: (_) => JeKTerreo());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          'BLOCOS J & K',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: const LatLng(-22.3296, -49.0531),
                    width: 150,
                    height: 50,
                    child: GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context, builder: (_) => LabEnf());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          'LAB. ENFERMAGEM & CLI. NUTRIÇÃO',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: const LatLng(-22.3312, -49.0516),
                    width: 75,
                    height: 35,
                    child: GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context, builder: (_) => BlocoOT());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          'BLOCO O',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: const LatLng(-22.3310, -49.0511),
                    width: 110,
                    height: 50,
                    child: GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context, builder: (_) => ClinicaOd());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          'CLÍNICA DE ODONTOLOGIA',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: const LatLng(-22.3318, -49.0513),
                    width: 75,
                    height: 35,
                    child: GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context, builder: (_) => BlocoLTerreo());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          'BLOCO L',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: const LatLng(-22.3321, -49.0512),
                    width: 150,
                    height: 50,
                    child: GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context, builder: (_) => Quadra());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          'QUADRA POLIESPORTIVA',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(-22.33176196, -49.0527159),
                    width: 150,
                    height: 50,
                    child: Icon(
                      Icons.directions_car,
                      size: 40,
                    ),
                  ),
                ],
              ),
              const MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(-22.32740519, -49.05332744),
                    width: 150,
                    height: 50,
                    child: Icon(
                      Icons.directions_car,
                      size: 40,
                    ),
                  ),
                ],
              ),
              const MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(-22.33216389, -49.0504843),
                    width: 150,
                    height: 50,
                    child: Icon(
                      Icons.directions_car,
                      size: 40,
                    ),
                  ),
                ],
              ),
              //#endregion
            ],
          ),
          Positioned(
              bottom: 10,
              left: 10,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "assets/cadrant_def.png",
                      scale: 3.7,
                    ),
                    Transform.rotate(
                      angle: ((heading ?? 0) * (pi / 180) * -1),
                      child: Image.asset(
                        "assets/compass.png",
                        scale: 3.8,
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'SELECIONE',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 100),
                        IconButton(
                            icon: const Icon(Icons.restart_alt_rounded),
                            tooltip: 'Apagar o percurso',
                            onPressed: () {
                              globalVariables.finalLoc.clear();
                              interpointFinal.clear();
                              interpointIni.clear();

                              processLatLngList(userLoc, interpointIni,
                                  interpointFinal, globalVariables.finalLoc);

                              globalVariables.bloco = 0;
                              globalVariables.andar = 0;
                            }),
                        const SizedBox(width: 5),
                        IconButton(
                          icon: const Icon(Icons.info),
                          tooltip: 'Informações sobre o destino',
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                String blocoText = '';
                                String andarText = '';
                                GlobalVariables globalVariables =
                                    GlobalVariables();
                                if (globalVariables.bloco == 1) {
                                  blocoText = 'Bloco A';
                                } else if (globalVariables.bloco == 2) {
                                  blocoText = 'Bloco B';
                                } else if (globalVariables.bloco == 3) {
                                  blocoText = 'Bloco C';
                                } else if (globalVariables.bloco == 4) {
                                  blocoText = 'Bloco D';
                                } else if (globalVariables.bloco == 5) {
                                  blocoText = 'Bloco E';
                                } else if (globalVariables.bloco == 6) {
                                  blocoText = 'Bloco F';
                                } else if (globalVariables.bloco == 7) {
                                  blocoText = 'Bloco G';
                                } else if (globalVariables.bloco == 8) {
                                  blocoText = 'Bloco J';
                                } else if (globalVariables.bloco == 9) {
                                  blocoText = 'Bloco K';
                                } else if (globalVariables.bloco == 10) {
                                  blocoText = 'Bloco O';
                                } else if (globalVariables.bloco == 11) {
                                  blocoText = 'Bloco L';
                                } else if (globalVariables.bloco == 12) {
                                  blocoText = 'Quadra';
                                } else if (globalVariables.bloco == 13) {
                                  blocoText =
                                      'Lab de Enfermagem & Cli Nutrição';
                                } else if (globalVariables.bloco == 14) {
                                  blocoText = 'Entre o Bloco K e o Bloco O';
                                } else {
                                  blocoText = 'N/A';
                                }

                                if (globalVariables.andar == 1) {
                                  andarText = 'Terreo';
                                } else if (globalVariables.andar == 2) {
                                  andarText = 'Primeiro Andar';
                                } else if (globalVariables.andar == 3) {
                                  andarText = 'Segundo Andar';
                                } else if (globalVariables.andar == 4) {
                                  andarText = 'Terceiro Andar';
                                } else if (globalVariables.andar == 5) {
                                  andarText = 'Presente em Todos os andares';
                                } else {
                                  andarText = 'N/A';
                                }

                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          const Text(
                                            'INFORMAÇÕES',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          IconButton(
                                            icon: const Icon(
                                                Icons.keyboard_return_rounded),
                                            tooltip: 'Voltar',
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          const SizedBox(width: 10),
                                          IconButton(
                                            icon: const Icon(Icons.add),
                                            tooltip: 'Mais Informações',
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ExplicaCaminho()),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        height: 2,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        'Bloco: $blocoText',
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'Andar: $andarText',
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 2,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 198,
                      child: ListView.builder(
                        itemCount: locais.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text(locais[index]),
                                onTap: () {
                                  setState(() {
                                    LatLng currentLocation = LatLng(
                                        globalVariables.posicao!.latitude,
                                        globalVariables.posicao!.longitude);
                                    noQuadrant = false;
                                    for (var entry in blocoQuadrantes.entries) {
                                      final polygon =
                                          Polygon(points: entry.value);
                                      final geodesy = Geodesy();
                                      if (geodesy.isGeoPointInPolygon(
                                          currentLocation, polygon.points)) {
                                        blocoAtual = entry.key;
                                        noQuadrant = true;
                                        break;
                                      }
                                    }
                                  });

                                  if (blocoAtual == 'Blocos A e B') {
                                    interpointIni.clear();
                                    interpointIni.add(
                                        const LatLng(-22.328239, -49.053016));
                                  } else if (blocoAtual == 'Blocos C, D e E') {
                                    interpointIni.clear();
                                    interpointIni.add(
                                        const LatLng(-22.328668, -49.052986));
                                  } else if (blocoAtual == 'Blocos F e G') {
                                    interpointIni.clear();
                                    interpointIni.add(
                                        const LatLng(-22.329061, -49.052811));
                                  } else if (blocoAtual == 'Bloco J') {
                                    interpointIni.clear();
                                    interpointIni.add(
                                        const LatLng(-22.330230, -49.052469));
                                  } else if (blocoAtual == 'Bloco K') {
                                    interpointIni.clear();
                                    interpointIni.add(
                                        const LatLng(-22.330603, -49.052341));
                                  } else if (blocoAtual == 'Bloco O') {
                                    interpointIni.clear();
                                    interpointIni.add(
                                        const LatLng(-22.331289, -49.052136));
                                  } else if (blocoAtual == 'Bloco L') {
                                    interpointIni.clear();
                                    interpointIni.add(
                                        const LatLng(-22.331819, -49.051816));
                                  } else if (blocoAtual == 'Quadra') {
                                    interpointIni.clear();
                                    interpointIni.add(
                                        const LatLng(-22.332206, -49.051580));
                                  } else if (blocoAtual == 'Enf') {
                                    interpointIni.clear();
                                    interpointIni.add(
                                        const LatLng(-22.329561, -49.052894));
                                  } else {
                                    interpointIni.clear();
                                  }

                                  //bloco ab
                                  if (index == 10 ||
                                      index == 18 ||
                                      index == 40 ||
                                      index == 42 ||
                                      index == 43 ||
                                      index == 64 ||
                                      index == 66) {
                                    globalVariables.finalLoc.clear();
                                    globalVariables.finalLoc
                                        .add(const LatLng(-22.3280, -49.0524));

                                    interpointFinal.clear();
                                    interpointFinal.add(
                                        const LatLng(-22.328239, -49.053016));

                                    processLatLngList(
                                        userLoc,
                                        interpointIni,
                                        interpointFinal,
                                        globalVariables.finalLoc);

                                    if (index == 40 ||
                                        index == 42 ||
                                        index == 43) {
                                      globalVariables.andar =
                                          2; //primeiro andar

                                      if (index == 43) {
                                        globalVariables.bloco = 1; //bloco a
                                      } else {
                                        globalVariables.bloco = 2; //bloco b
                                      }
                                    } else {
                                      globalVariables.andar = 1; //terreo
                                      if (index == 10) {
                                        globalVariables.bloco = 1; //bloco a
                                      } else {
                                        globalVariables.bloco = 2; //bloco b
                                      }
                                    }
                                  }

                                  //bloco C D E
                                  else if (index == 11 ||
                                      index == 19 ||
                                      index == 26 ||
                                      index == 29 ||
                                      index == 35 ||
                                      index == 45 ||
                                      index == 46 ||
                                      index == 67 ||
                                      index == 20 ||
                                      index == 04 ||
                                      index == 05 ||
                                      index == 21 ||
                                      index == 30 ||
                                      index == 47 ||
                                      index == 48 ||
                                      index == 49 ||
                                      index == 50 ||
                                      index == 63) {
                                    globalVariables.finalLoc.clear();
                                    globalVariables.finalLoc.add(
                                        const LatLng(-22.328469, -49.052305));

                                    interpointFinal.clear();
                                    interpointFinal.add(
                                        const LatLng(-22.328668, -49.052986));

                                    processLatLngList(
                                        userLoc,
                                        interpointIni,
                                        interpointFinal,
                                        globalVariables.finalLoc);

                                    if (index == 11 ||
                                        index == 45 ||
                                        index == 46 ||
                                        index == 47 ||
                                        index == 48 ||
                                        index == 49 ||
                                        index == 50) {
                                      globalVariables.andar =
                                          2; //primeiro andar
                                      if (index == 11 ||
                                          index == 45 ||
                                          index == 46) {
                                        globalVariables.bloco = 3; //bloco c
                                      }
                                      if (index == 47 || index == 48) {
                                        globalVariables.bloco = 4; // bloco d
                                      }
                                      if (index == 49 || index == 50) {
                                        globalVariables.bloco = 5; //bloco e
                                      }
                                    }
                                    if (index == 19 ||
                                        index == 26 ||
                                        index == 29 ||
                                        index == 35 ||
                                        index == 67 ||
                                        index == 04 ||
                                        index == 05 ||
                                        index == 21 ||
                                        index == 30 ||
                                        index == 20) {
                                      globalVariables.andar = 1; //terrero
                                      if (index == 19 ||
                                          index == 26 ||
                                          index == 29 ||
                                          index == 35 ||
                                          index == 67) {
                                        globalVariables.bloco = 3; //bloco c
                                      }
                                      if (index == 20) {
                                        globalVariables.bloco = 4; //bloco d
                                      }
                                      if (index == 04 ||
                                          index == 05 ||
                                          index == 21 ||
                                          index == 30) {
                                        globalVariables.bloco = 5; //bloco e
                                      }
                                    }
                                    if (index == 63) {
                                      globalVariables.bloco = 5; //bloco e
                                      globalVariables.andar = 5; //todos
                                    }
                                  }

                                  //bloco F e G
                                  else if (index == 00 ||
                                      index == 01 ||
                                      index == 02 ||
                                      index == 03 ||
                                      index == 34 ||
                                      index == 39 ||
                                      index == 51 ||
                                      index == 52 ||
                                      index == 12 ||
                                      index == 13 ||
                                      index == 53 ||
                                      index == 54) {
                                    globalVariables.finalLoc.clear();
                                    globalVariables.finalLoc.add(
                                        const LatLng(-22.328906, -49.052079));

                                    interpointFinal.clear();
                                    interpointFinal.add(
                                        const LatLng(-22.329061, -49.052811));

                                    processLatLngList(
                                        userLoc,
                                        interpointIni,
                                        interpointFinal,
                                        globalVariables.finalLoc);

                                    if (index == 00 ||
                                        index == 01 ||
                                        index == 34 ||
                                        index == 02 ||
                                        index == 03 ||
                                        index == 12 ||
                                        index == 13 ||
                                        index == 39) {
                                      globalVariables.andar = 1; //terreo

                                      if (index == 01 ||
                                          index == 02 ||
                                          index == 03 ||
                                          index == 39) {
                                        globalVariables.bloco = 6; //bloco F
                                      }

                                      if (index == 0 ||
                                          index == 12 ||
                                          index == 13) {
                                        globalVariables.bloco = 7; //bloco g
                                      }

                                      if (index == 34) {
                                        globalVariables.bloco = 6; //bloco f
                                        globalVariables.andar =
                                            5; //todos os andares
                                      }
                                    }

                                    if (index == 51 ||
                                        index == 52 ||
                                        index == 53 ||
                                        index == 54) {
                                      globalVariables.andar =
                                          2; //primeiro andar
                                      if (index == 51 || index == 52) {
                                        globalVariables.bloco = 6; //bloco F
                                      }

                                      if (index == 53 || index == 54) {
                                        globalVariables.bloco = 7; //bloco g
                                      }
                                    }
                                  }

                                  //bloco J
                                  else if (index == 08 ||
                                      index == 09 ||
                                      index == 24 ||
                                      index == 25 ||
                                      index == 28 ||
                                      index == 36 ||
                                      index == 38 ||
                                      index == 44 ||
                                      index == 55 ||
                                      index == 56) {
                                    globalVariables.finalLoc.clear();
                                    globalVariables.finalLoc.add(
                                        const LatLng(-22.330077, -49.051746));

                                    interpointFinal.clear();
                                    interpointFinal.add(
                                        const LatLng(-22.330230, -49.052469));

                                    processLatLngList(
                                        userLoc,
                                        interpointIni,
                                        interpointFinal,
                                        globalVariables.finalLoc);

                                    globalVariables.bloco = 8; //bloco j
                                    if (index == 24 || index == 44) {
                                      globalVariables.andar = 1; //terreo
                                    }
                                    if (index == 8 ||
                                        index == 9 ||
                                        index == 28 ||
                                        index == 36) {
                                      globalVariables.andar =
                                          2; //primeiro andar
                                    }
                                    if (index == 25 || index == 38) {
                                      globalVariables.andar = 4; //segundo andar
                                    }
                                    if (index == 55 || index == 56) {
                                      globalVariables.andar = 5; //todos
                                    }
                                  }

                                  //bloco K
                                  else if (index == 14 ||
                                      index == 17 ||
                                      index == 22 ||
                                      index == 23 ||
                                      index == 32 ||
                                      index == 33 ||
                                      index == 37 ||
                                      index == 57 ||
                                      index == 58) {
                                    globalVariables.finalLoc.clear();
                                    globalVariables.finalLoc.add(
                                        const LatLng(-22.330476, -49.051667));

                                    interpointFinal.clear();
                                    interpointFinal.add(
                                        const LatLng(-22.330603, -49.052341));

                                    processLatLngList(
                                        userLoc,
                                        interpointIni,
                                        interpointFinal,
                                        globalVariables.finalLoc);

                                    globalVariables.bloco = 9; //bloco k
                                    if (index == 37) {
                                      globalVariables.andar = 1; //terreo
                                    }
                                    if (index == 14 ||
                                        index == 17 ||
                                        index == 22 ||
                                        index == 33 ||
                                        index == 32) {
                                      globalVariables.andar =
                                          2; //primeiro andar
                                    }
                                    if (index == 33) {
                                      globalVariables.andar = 3; //segundo andar
                                    }
                                    if (index == 23) {
                                      globalVariables.andar =
                                          4; //terceiro andar
                                    }
                                    if (index == 57 || index == 58) {
                                      globalVariables.andar = 5; //todos
                                    }
                                  }

                                  //entre o bloco K e O
                                  else if (index == 65) {
                                    globalVariables.finalLoc.clear();
                                    globalVariables.finalLoc.add(
                                        const LatLng(-22.330629, -49.051396));

                                    interpointFinal.clear();
                                    interpointIni.clear();

                                    processLatLngList(
                                        userLoc,
                                        interpointIni,
                                        interpointFinal,
                                        globalVariables.finalLoc);

                                    globalVariables.andar = 1; //terreo
                                    globalVariables.bloco = 14; //entre k e o
                                  }

                                  //bloco O
                                  else if (index == 07 ||
                                      index == 16 ||
                                      index == 27 ||
                                      index == 59 ||
                                      index == 60) {
                                    globalVariables.finalLoc.clear();
                                    globalVariables.finalLoc.add(
                                        const LatLng(-22.331153, -49.051646));

                                    interpointFinal.clear();
                                    interpointFinal.add(
                                        const LatLng(-22.331289, -49.052136));

                                    processLatLngList(
                                        userLoc,
                                        interpointIni,
                                        interpointFinal,
                                        globalVariables.finalLoc);

                                    globalVariables.bloco = 10; //bloco O

                                    if (index == 07 ||
                                        index == 16 ||
                                        index == 27) {
                                      globalVariables.andar = 1; //terreo
                                    } else {
                                      globalVariables.andar =
                                          2; //primeiro andar
                                    }
                                  }

                                  //bloco L
                                  else if (index == 06 ||
                                      index == 31 ||
                                      index == 61 ||
                                      index == 62) {
                                    globalVariables.finalLoc.clear();
                                    globalVariables.finalLoc.add(
                                        const LatLng(-22.331833, -49.051275));

                                    interpointFinal.clear();
                                    interpointFinal.add(
                                        const LatLng(-22.331819, -49.051816));

                                    processLatLngList(
                                        userLoc,
                                        interpointIni,
                                        interpointFinal,
                                        globalVariables.finalLoc);

                                    globalVariables.bloco = 11; //bloco L

                                    if (index == 6 || index == 31) {
                                      globalVariables.andar =
                                          1; //primeiro andar
                                    } else {
                                      globalVariables.andar = 2; //segundo andar
                                    }
                                  }

                                  //quadra
                                  else if (index == 41) {
                                    globalVariables.finalLoc.clear();
                                    globalVariables.finalLoc.add(
                                        const LatLng(-22.332123, -49.051210));

                                    interpointFinal.clear();
                                    interpointFinal.add(
                                        const LatLng(-22.332206, -49.051580));

                                    processLatLngList(
                                        userLoc,
                                        interpointIni,
                                        interpointFinal,
                                        globalVariables.finalLoc);

                                    globalVariables.bloco = 12; //quadra
                                    globalVariables.andar = 1; //terreo
                                  }

                                  //rua
                                  else if (index == 15) {
                                    globalVariables.finalLoc.clear();
                                    globalVariables.finalLoc.add(
                                        const LatLng(-22.329662, -49.053067));

                                    interpointFinal.clear();
                                    interpointFinal.add(
                                        const LatLng(-22.329561, -49.052894));

                                    processLatLngList(
                                        userLoc,
                                        interpointIni,
                                        interpointFinal,
                                        globalVariables.finalLoc);

                                    globalVariables.bloco =
                                        13; //atravessando a rua
                                    globalVariables.andar = 1; // terreo
                                  }

                                  if (interpointIni.any((element) =>
                                      interpointFinal.contains(element))) {
                                    interpointIni.clear();
                                    interpointFinal.clear();

                                    processLatLngList(
                                        userLoc,
                                        interpointIni,
                                        interpointFinal,
                                        globalVariables.finalLoc);
                                  }
                                  Navigator.pop(context);
                                },
                              ),
                              if (index < locais.length - 1) const Divider(),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        tooltip: 'Selecione seu destino',
        backgroundColor: Colors.red,
        child: const Icon(Icons.navigation),
      ),
    );
  }
}
