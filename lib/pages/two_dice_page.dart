import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pest/cubit/game_cubit.dart';
import 'package:pest/widgets/dice_widget.dart';
import 'package:pest/widgets/player_counter.dart';

class TwoDicePage extends StatelessWidget {
  const TwoDicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<GameCubit, GameState>(
      listener: (context, state) {
        if (state is RoundStarted) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const TwoDicePage()));
        }
      },
      child: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PlayerCounter(playerCount: state.players),
              Text(state is RollingOut
                  ? "Pest auswürfeln"
                  : "Du bist die Pest!"),
              DiceWidget(side: state.dices[0]),
              DiceWidget(side: state.dices[1]),
              Visibility(
                visible: state is RolledOut,
                child: ElevatedButton(
                    onPressed: () => context.read<GameCubit>().startRound(),
                    child: const Text("weiter")),
              )
            ],
          );
        },
      ),
    ));
  }
}
