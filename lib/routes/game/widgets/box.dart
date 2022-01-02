import 'package:flutter/material.dart';
import 'package:mines/routes/game/widgets/cell.dart';

class Box extends StatefulWidget {
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
  State<Box> createState() => _BoxState();
}

class _BoxState extends State<Box> {
  bool _isFlagged = false;

  void _toggleFlag() => setState(() {
        _isFlagged = !_isFlagged;
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        child: widget.isVisible
            ? Container(
                padding: const EdgeInsets.all(8),
                child: widget.content,
              )
            : Container(
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(20),
                // ),
                color: Theme.of(context).primaryColorLight,
                child:
                    _isFlagged ? Image.asset('assets/images/flag.png') : null,
              ),
        width: widget.size,
        height: widget.size,
      ),
      onTap: () => _isFlagged
          ? _toggleFlag()
          : widget.onTap(widget.xCoord, widget.yCoord),
      onLongPress: _toggleFlag,
    );
  }
}
