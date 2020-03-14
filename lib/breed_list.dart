import 'package:flutter/material.dart';
import 'package:flutter_doggopedia/models/breeds.dart';
import 'package:flutter_doggopedia/services.dart';

class BreedList extends StatefulWidget {
  BreedList({Key key}) : super(key: key);

  @override
  _BreedList createState() => _BreedList();
}

class _BreedList extends State<BreedList> {
  Breeds _breeds;

  _BreedList();

  @override
  Widget build(BuildContext context) {
    fetchData() async {
      var breedImages = await getBreedImages('akita');
      var fetchedBreeds = await getBreeds();
      setState(() {
        _breeds = fetchedBreeds;
        print('akita breed images: ${breedImages.message[0]}');
      });
    }

    if (_breeds == null) {
      fetchData();
    }

    List<Widget> list = new List<Widget>();
    if (_breeds != null) {
      _breeds.message.forEach((key, value) {
        list.add(
          Row(
            children: <Widget>[
              Expanded(
                child: Image.network(
                    'https://i.ytimg.com/vi/AZ2ZPmEfjvU/maxresdefault.jpg'),
              ),
              Expanded(
                child: Text(
                  key,
                  style: TextStyle(
                      color: Color.fromRGBO(125, 30, 200, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Icon(Icons.play_arrow),
              )
            ],
          ),
        );
      });
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
