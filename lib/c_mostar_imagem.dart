import 'package:flutter/material.dart';

class AeBTerreo extends StatelessWidget {
  const AeBTerreo({super.key});

  @override
  Widget build(BuildContext context) {
    TransformationController transformationController =
    TransformationController();

    transformationController.value = Matrix4.identity()
      ..translate(0.5, 0.5)
      ..scale(1.0);

    return Dialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: 900,
                  height: 900,
                  child: InteractiveViewer(
                    transformationController: transformationController,
                    boundaryMargin: const EdgeInsets.all(20.0),
                    minScale: 0.1,
                    maxScale: 4.0,
                    constrained: false,
                    panEnabled: true,
                    child: Image.asset('assets/PlantaBlocoAeB_Terreo.jpg'),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.keyboard_arrow_up_rounded),
                      onPressed: () async{
                        await showDialog(context: context,
                            builder: (_) => AeBpiso1()
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'DICA: USE O CELULAR NA HORIZONTAL!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class AeBpiso1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransformationController _transformationController =
    TransformationController();

    _transformationController.value = Matrix4.identity()
      ..translate(0.5, 0.5)
      ..scale(1.0);

    return Dialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: 900,
                  height: 900,
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    boundaryMargin: const EdgeInsets.all(20.0),
                    minScale: 0.1,
                    maxScale: 4.0,
                    constrained: false,
                    panEnabled: true,
                    child: Image.asset('assets/PlantaBlocoAeB_piso1.jpg'),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      onPressed: () async{
                        await showDialog(context: context,
                            builder: (_) => const AeBTerreo()
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'DICA: USE O CELULAR NA HORIZONTAL!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class CDETerreo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransformationController _transformationController =
    TransformationController();

    _transformationController.value = Matrix4.identity()
      ..translate(0.5, 0.5)
      ..scale(1.0);

    return Dialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: 900,
                  height: 900,
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    boundaryMargin: const EdgeInsets.all(20.0),
                    minScale: 0.1,
                    maxScale: 4.0,
                    constrained: false,
                    panEnabled: true,
                    child: Image.asset('assets/PlantaBlocoCDE_Terreo.jpg'),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.keyboard_arrow_up_rounded),
                      onPressed: () async{
                        await showDialog(context: context,
                            builder: (_) => CDEPiso1()
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'DICA: USE O CELULAR NA HORIZONTAL!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class CDEPiso1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransformationController _transformationController =
    TransformationController();

    _transformationController.value = Matrix4.identity()
      ..translate(0.5, 0.5)
      ..scale(1.0);

    return Dialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: 900,
                  height: 900,
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    boundaryMargin: const EdgeInsets.all(20.0),
                    minScale: 0.1,
                    maxScale: 4.0,
                    constrained: false,
                    panEnabled: true,
                    child: Image.asset('assets/PlantaBlocoCDE_Piso1.jpg'),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      onPressed: () async{
                        await showDialog(context: context,
                            builder: (_) => CDETerreo()
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'DICA: USE O CELULAR NA HORIZONTAL!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class FeGTerreo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransformationController _transformationController =
    TransformationController();

    _transformationController.value = Matrix4.identity()
      ..translate(0.5, 0.5)
      ..scale(1.0);

    return Dialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: 900,
                  height: 900,
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    boundaryMargin: const EdgeInsets.all(20.0),
                    minScale: 0.1,
                    maxScale: 4.0,
                    constrained: false,
                    panEnabled: true,
                    child: Image.asset('assets/PlantaBlocoFeG_Terreo.jpg'),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.keyboard_arrow_up_rounded),
                      onPressed: () async{
                        await showDialog(context: context,
                            builder: (_) => FeGPiso1()
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'DICA: USE O CELULAR NA HORIZONTAL!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class FeGPiso1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransformationController _transformationController =
    TransformationController();

    _transformationController.value = Matrix4.identity()
      ..translate(0.5, 0.5)
      ..scale(1.0);

    return Dialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: 900,
                  height: 900,
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    boundaryMargin: const EdgeInsets.all(20.0),
                    minScale: 0.1,
                    maxScale: 4.0,
                    constrained: false,
                    panEnabled: true,
                    child: Image.asset('assets/PlantaBlocoFeG_Piso1.jpg'),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      onPressed: () async{
                        await showDialog(context: context,
                            builder: (_) => FeGTerreo()
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'DICA: USE O CELULAR NA HORIZONTAL!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class JeKTerreo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransformationController _transformationController =
    TransformationController();

    _transformationController.value = Matrix4.identity()
      ..translate(0.5, 0.5)
      ..scale(1.0);

    return Dialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: 900,
                  height: 900,
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    boundaryMargin: const EdgeInsets.all(20.0),
                    minScale: 0.1,
                    maxScale: 4.0,
                    constrained: false,
                    panEnabled: true,
                    child: Image.asset('assets/PlantaBlocoJeK_Terreo.jpg'),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.keyboard_arrow_up_rounded),
                      onPressed: () async{
                        await showDialog(context: context,
                            builder: (_) => JeKPiso1()
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'DICA: USE O CELULAR NA HORIZONTAL!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class JeKPiso1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransformationController _transformationController =
    TransformationController();

    _transformationController.value = Matrix4.identity()
      ..translate(0.5, 0.5)
      ..scale(1.0);

    return Dialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: 900,
                  height: 900,
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    boundaryMargin: const EdgeInsets.all(20.0),
                    minScale: 0.1,
                    maxScale: 4.0,
                    constrained: false,
                    panEnabled: true,
                    child: Image.asset('assets/PlantaBlocoJeK_P_Andar.jpg'),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.keyboard_arrow_up_rounded),
                      onPressed: () async{
                        await showDialog(context: context,
                            builder: (_) => JeKPiso2()
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 70,
                  right: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      onPressed: () async{
                        await showDialog(context: context,
                            builder: (_) => JeKTerreo()
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'DICA: USE O CELULAR NA HORIZONTAL!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class JeKPiso2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransformationController _transformationController =
    TransformationController();

    _transformationController.value = Matrix4.identity()
      ..translate(0.5, 0.5)
      ..scale(1.0);

    return Dialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: 900,
                  height: 900,
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    boundaryMargin: const EdgeInsets.all(20.0),
                    minScale: 0.1,
                    maxScale: 4.0,
                    constrained: false,
                    panEnabled: true,
                    child: Image.asset('assets/PlantaBlocoJeK_S_Andar.jpg'),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.keyboard_arrow_up_rounded),
                      onPressed: () async{
                        await showDialog(context: context,
                            builder: (_) => JeKPiso3()
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 70,
                  right: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      onPressed: () async{
                        await showDialog(context: context,
                            builder: (_) => JeKPiso1()
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'DICA: USE O CELULAR NA HORIZONTAL!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class JeKPiso3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransformationController _transformationController =
    TransformationController();

    _transformationController.value = Matrix4.identity()
      ..translate(0.5, 0.5)
      ..scale(1.0);

    return Dialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: 900,
                  height: 900,
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    boundaryMargin: const EdgeInsets.all(20.0),
                    minScale: 0.1,
                    maxScale: 4.0,
                    constrained: false,
                    panEnabled: true,
                    child: Image.asset('assets/PlantaBlocoJeK_T_Andar.jpg'),
                  ),
                ),

                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      onPressed: () async{
                        await showDialog(context: context,
                            builder: (_) => JeKPiso2()
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'DICA: USE O CELULAR NA HORIZONTAL!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class LabEnf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransformationController _transformationController =
    TransformationController();

    _transformationController.value = Matrix4.identity()
      ..translate(0.5, 0.5)
      ..scale(1.0);

    return Dialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: 900,
                  height: 900,
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    boundaryMargin: const EdgeInsets.all(20.0),
                    minScale: 0.1,
                    maxScale: 4.0,
                    constrained: false,
                    panEnabled: true,
                    child: Image.asset('assets/PlantaLabEnfermagemTerreo.jpg'),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      onPressed: () async{
                        await showDialog(context: context,
                            builder: (_) => LabEnfInf()
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'DICA: USE O CELULAR NA HORIZONTAL!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class LabEnfInf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransformationController _transformationController =
    TransformationController();

    _transformationController.value = Matrix4.identity()
      ..translate(0.5, 0.5)
      ..scale(1.0);

    return Dialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: 900,
                  height: 900,
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    boundaryMargin: const EdgeInsets.all(20.0),
                    minScale: 0.1,
                    maxScale: 4.0,
                    constrained: false,
                    panEnabled: true,
                    child: Image.asset('assets/PlantaLabEnfermagemInf.jpg'),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.keyboard_arrow_up_rounded),
                      onPressed: () async{
                        await showDialog(context: context,
                            builder: (_) => LabEnf()
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'DICA: USE O CELULAR NA HORIZONTAL!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class BlocoOT extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransformationController _transformationController =
    TransformationController();

    _transformationController.value = Matrix4.identity()
      ..translate(0.5, 0.5)
      ..scale(1.0);

    return Dialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: 900,
                  height: 900,
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    boundaryMargin: const EdgeInsets.all(20.0),
                    minScale: 0.1,
                    maxScale: 4.0,
                    constrained: false,
                    panEnabled: true,
                    child: Image.asset('assets/PlantaBlocoOTerreo.jpg'),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.keyboard_arrow_up_rounded),
                      onPressed: () async{
                        await showDialog(context: context,
                            builder: (_) => BlocoO1()
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'DICA: USE O CELULAR NA HORIZONTAL!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class BlocoO1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransformationController _transformationController =
    TransformationController();

    _transformationController.value = Matrix4.identity()
      ..translate(0.5, 0.5)
      ..scale(1.0);

    return Dialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: 900,
                  height: 900,
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    boundaryMargin: const EdgeInsets.all(20.0),
                    minScale: 0.1,
                    maxScale: 4.0,
                    constrained: false,
                    panEnabled: true,
                    child: Image.asset('assets/PlantaBlocoOPiso1.jpg'),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.keyboard_arrow_up_rounded),
                      onPressed: () async{
                        await showDialog(context: context,
                            builder: (_) => BlocoOT()
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'DICA: USE O CELULAR NA HORIZONTAL!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ClinicaOd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransformationController _transformationController =
    TransformationController();

    _transformationController.value = Matrix4.identity()
      ..translate(0.5, 0.5)
      ..scale(1.0);

    return Dialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: 900,
                  height: 900,
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    boundaryMargin: const EdgeInsets.all(20.0),
                    minScale: 0.1,
                    maxScale: 4.0,
                    constrained: false,
                    panEnabled: true,
                    child: Image.asset('assets/PlantaClinica.jpg'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'DICA: USE O CELULAR NA HORIZONTAL!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class BlocoLTerreo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransformationController _transformationController =
    TransformationController();

    _transformationController.value = Matrix4.identity()
      ..translate(0.5, 0.5)
      ..scale(1.0);

    return Dialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: 900,
                  height: 900,
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    boundaryMargin: const EdgeInsets.all(20.0),
                    minScale: 0.1,
                    maxScale: 4.0,
                    constrained: false,
                    panEnabled: true,
                    child: Image.asset('assets/PlantaBlocoLTerreo.jpg'),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.keyboard_arrow_up_rounded),
                      onPressed: () async{
                        await showDialog(context: context,
                            builder: (_) => BlocoLPiso1()
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'DICA: USE O CELULAR NA HORIZONTAL!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class BlocoLPiso1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransformationController _transformationController =
    TransformationController();

    _transformationController.value = Matrix4.identity()
      ..translate(0.5, 0.5)
      ..scale(2.0);

    return Dialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: 900,
                  height: 900,
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    boundaryMargin: const EdgeInsets.all(20.0),
                    minScale: 0.1,
                    maxScale: 4.0,
                    constrained: false,
                    panEnabled: true,
                    child: Image.asset('assets/PlantaBlocoLPiso1.jpg'),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      onPressed: () async{
                        await showDialog(context: context,
                            builder: (_) => BlocoLTerreo()
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'DICA: USE O CELULAR NA HORIZONTAL!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class Quadra extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransformationController _transformationController =
    TransformationController();

    _transformationController.value = Matrix4.identity()
      ..translate(0.5, 0.5)
      ..scale(1.0);

    return Dialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: 900,
                  height: 900,
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    boundaryMargin: const EdgeInsets.all(20.0),
                    minScale: 0.1,
                    maxScale: 4.0,
                    constrained: false,
                    panEnabled: true,
                    child: Image.asset('assets/PlantaQuadra.jpg'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'DICA: USE O CELULAR NA HORIZONTAL!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}