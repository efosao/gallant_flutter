import 'package:flutter/material.dart';
import 'package:flutter_doggopedia/store/images.dart';
import 'package:provider/provider.dart';
import 'components/breed_list.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ImagesStore(),
      child: RootApp(),
    ),
  );
}

class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BreedList(),
    );
  }
}
