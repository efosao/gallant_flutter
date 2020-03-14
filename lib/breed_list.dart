import 'package:flutter/material.dart';

class BreedList extends StatefulWidget {
  BreedList({Key key}) : super(key: key);

  @override
  _BreedList createState() => _BreedList();
}

class _BreedList extends State<BreedList> {
  @override
  Widget build(BuildContext context) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < 200; i++) {
      list.add(
        Row(
          children: <Widget>[
            Expanded(
              child: Image.network(
                  'https://i.ytimg.com/vi/AZ2ZPmEfjvU/maxresdefault.jpg'),
            ),
            Expanded(
              child: Text(
                'Great Dane ${i + 1}',
                style: TextStyle(
                  color: Color.fromRGBO(125, 30, 200, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.w500),),
            ),
            Expanded(
              child: Icon(Icons.play_arrow),
            )
          ],
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Breed Finder'),
        ),
        body: Container(
          child: (ListView(
            padding: EdgeInsets.all(0),
            children: list,
          )),
        ));
  }
}
