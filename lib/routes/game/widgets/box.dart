import 'package:flutter/material.dart';
import 'package:mines/routes/game/widgets/cell.dart';

class Box extends StatefulWidget {
  final CellWidget content;
  final int xCoord;
  final int yCoord;
  final double size = 32;
  final Function(int xCoord, int yCoord) onTap;

  const Box(
      {Key? key,
      required this.content,
      required this.xCoord,
      required this.yCoord,
      required this.onTap})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BoxState();
}

class _BoxState extends State<Box> {
  bool _isVisible = false;

  _onTap() {
    if (!_isVisible) {
      widget.onTap(widget.xCoord, widget.yCoord);
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
                child: widget.content,
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
      onTap: _isVisible ? null : _onTap,
    );
  }
}
