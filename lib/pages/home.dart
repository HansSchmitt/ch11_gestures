import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildGestureDetector(),
              Divider(),
              _buildDraggable(),
              Divider(),
              _buildDragTarget(),
            ],
          ),
        ),
      ),
    );
  }

  String _gestureDetected;

  Widget _buildGestureDetector() {
    return GestureDetector(
      onTap: () {
        print('on tap');
        _displayGestureDetected('onTap');
      },
      onDoubleTap: () {
        print('onLongPress');
        _displayGestureDetected('onDoubleTap');
      },
      onLongPress: () {
        print('onLongPress');
        _displayGestureDetected('onLongPress');
      },
      onPanUpdate: (DragUpdateDetails details) {
        print('onPanUpdate $details');
        _displayGestureDetected('onPanUpdate: \n$details');
      },
      child: Container(
        width: double.infinity,
        color: Colors.lightGreen,
        padding: EdgeInsets.all(24),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.gesture,
              size: 98.0,
            ),
            Text('$_gestureDetected'),
          ],
        ),
      ),
    );
  }

  void _displayGestureDetected(String gesture) {
    setState(() {
      _gestureDetected = gesture;
    });
  }

  Widget _buildDraggable() {
    return Draggable(
      child: Column(
        children: <Widget>[
          Icon(
            Icons.palette,
            size: 48.0,
            color: Colors.deepOrange,
          ),
          Text('Drag me below to change color'),
        ],
      ),
      childWhenDragging: Icon(
        Icons.palette,
        color: Colors.grey,
        size: 48.0,
      ),
      feedback: Icon(
        Icons.brush,
        color: Colors.deepOrange,
        size: 80.0,
      ),
      data: Colors.deepOrange.value,
    );
  }

  Color _paintedColor;
  DragTarget<int> _buildDragTarget() {
    return DragTarget<int>(onAccept: (colorValue) {
      _paintedColor = Color(colorValue);
    }, builder: (BuildContext context, List<dynamic> acceptedData,
        List<dynamic> rejectedData) {
      return acceptedData.isEmpty
          ? Text(
              'Drag to and see color change',
              style: TextStyle(color: _paintedColor),
            )
          : Text(
              'PaintingColor: $acceptedData',
              style: TextStyle(
                color: Color(acceptedData[0]),
                fontWeight: FontWeight.bold,
              ),
            );
    });
  }
}
