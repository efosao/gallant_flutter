import 'package:flutter/material.dart';
import 'package:flutter_doggopedia/store/counter_store.dart';
import 'package:flutter_doggopedia/store/images_store.dart';
import 'package:provider/provider.dart';
import 'components/breed_list.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ImagesStore()),
        ChangeNotifierProvider(create: (context) => CounterStore()),
      ],
      child: RootApp(),
    ),
  );
}

class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Breed Finder',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: BreedList(),
    );
  }
}
