import 'package:flutter/material.dart';
import 'package:mines/routes.dart';
import 'package:mines/routes/game/game.dart';
import 'package:mines/routes/home/widgets/settings_dialog.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          widthFactor: double.infinity,
          heightFactor: double.infinity,
          child: Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16,
            children: [
              ElevatedButton(
                  child: const Text('Start'),
                  onPressed: () => showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => const SettingsDialog())
                      .then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Game(
                                gameSize: (value as Settings).size,
                                totalMines: value.mines,
                              ),
                            ),
                          ))),
              ElevatedButton(
                child: const Text('Statistics'),
                onPressed: () => Navigator.pushNamed(context, Routes.stats),
              )
            ],
          )),
    );
  }
}
