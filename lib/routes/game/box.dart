import 'package:flutter/material.dart';
import 'package:mines/routes/game/game.dart';

class Box extends StatefulWidget {
  final Cell cell;
  final double size = 32;

  const Box({Key? key, required this.cell}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BoxState();
}

class _BoxState extends State<Box> {
  bool _isVisible = false;

  _handleTap() {
    if (!_isVisible) {
      setState(() {
        _isVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        child: _isVisible
            ? Center(
                child: Text(widget.cell.isMine
                    ? 'mine'
                    : widget.cell.aroundMines.toString()),
              )
            : Container(
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(20),
                // ),
                color: Theme.of(context).primaryColorLight,
              ),
        width: widget.size,
        height: widget.size,
      ),
      onTap: _isVisible ? null : _handleTap,
    );
  }
}
