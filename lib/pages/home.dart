import 'package:flutter/material.dart';
import '../components/gradient_rounded_button.dart';
import '../pages/CorrigirTeste.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: const [
            CircleAvatar(
              backgroundImage: AssetImage('assets/logo_no_bg.png'),
              backgroundColor: Color(0xFFefefef),
            ),
            Padding(padding: EdgeInsets.only(right: 45, top: 45))
          ],
          backgroundColor: const Color(0xFFefefef),
          elevation: 0,
        ),
        backgroundColor: const Color(0xFFefefef),
        body: Center(
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GradientRoundedButton(
                onPressed: (() => {
                 Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const CorrigirTest(),
                    fullscreenDialog: true,
                  ),
                )
                }),
                colors: const [
                  Color.fromARGB(255, 44, 230, 236),
                  Color.fromARGB(255, 143, 227, 241),
                  Color.fromARGB(255, 152, 238, 152),
                ], 
                child:  const Text("Corrigir teste   "),
                ),

                GradientRoundedButton(
                onPressed: (() => {
                  // ignore: avoid_print
                  print(
                    "Importar teste"
                  )
                }),
                colors: const [
                  Color.fromARGB(255, 44, 230, 236),
                  Color.fromARGB(255, 143, 227, 241),
                  Color.fromARGB(255, 152, 238, 152),
                ], 
                child:  const Text("Importar teste"),
                ),
                GradientRoundedButton(
                onPressed: (() => {
                  // ignore: avoid_print
                  print(
                    "Imprimir teste"
                  )
                }),
                colors: const [
                  Color.fromARGB(255, 44, 230, 236),
                  Color.fromARGB(255, 143, 227, 241),
                  Color.fromARGB(255, 152, 238, 152),
                ], 
                child:  const Text("Imprimir teste"),
                )
             ],
          )),
        ));
  }
}
