import 'package:flutter/material.dart';
import 'package:mines/routes/game/widgets/cell.dart';

class Box extends StatelessWidget {
  final CellWidget content;
  final int xCoord;
  final int yCoord;
  final double size = 32;
  final bool isVisible;
  final Function(int xCoord, int yCoord) onTap;

  const Box(
      {Key? key,
      required this.content,
      required this.xCoord,
      required this.yCoord,
      required this.onTap,
      this.isVisible = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        child: isVisible
            ? Center(
                child: content,
              )
            : Container(
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(20),
                // ),
                color: Theme.of(context).primaryColorLight,
              ),
        width: size,
        height: size,
      ),
      onTap: () => onTap(xCoord, yCoord),
    );
  }
}
