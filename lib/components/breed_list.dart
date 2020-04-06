import 'package:flutter/material.dart';
import 'package:flutter_doggopedia/components/breed_list_row.dart';
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
      var fetchedBreeds = await getBreeds();
      setState(() {
        _breeds = fetchedBreeds;
      });
    }

    if (_breeds == null) {
      fetchData();
    }

    List<Widget> list = new List<Widget>();

    if (_breeds != null) {
      _breeds.message.forEach((key, value) {
        list.add(BreedListRow(
          key: Key(key),
          name: key,
          secondaryBreeds: value,
        ));
      });
    }

    final appBar = AppBar(
      title: Text('Breed Finder'),
      toolbarOpacity: 0.8,
      backgroundColor: Color.fromARGB(100, 100, 50, 50),
    );

    final toolbarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: appBar,
        body: Container(
          child: (ListView(
            padding: EdgeInsets.all(0),
            children: [Container(height: appBar.preferredSize.height + toolbarHeight), ...list],
          )),
        ));
  }
}
