import 'package:flutter/material.dart';
import 'package:mines/routes/game/widgets/cell.dart';

enum BoxStatus { visible, notVisible, flagged }

class Box extends StatelessWidget {
  final CellWidget content;
  final int xCoord;
  final int yCoord;
  final double size = 32;
  final BoxStatus status;
  final Function(int xCoord, int yCoord, BoxStatus status) onTap;
  final Function(int xCoord, int yCoord, BoxStatus status) onLongPress;

  const Box(
      {Key? key,
      required this.content,
      required this.xCoord,
      required this.yCoord,
      required this.onTap,
      required this.onLongPress,
      this.status = BoxStatus.notVisible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        child: status == BoxStatus.visible
            ? Container(
                padding: const EdgeInsets.all(8),
                child: content,
              )
            : Container(
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(20),
                // ),
                color: Theme.of(context).primaryColorLight,
                child: status == BoxStatus.flagged
                    ? Image.asset('assets/images/flag.png')
                    : null,
              ),
        width: size,
        height: size,
      ),
      onTap: () => onTap(xCoord, yCoord, status),
      onLongPress: () => onLongPress(xCoord, yCoord, status),
    );
  }
}
