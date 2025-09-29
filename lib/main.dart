
import 'package:flutter/material.dart';
import 'package:nch/providers/hymnal_model.dart';
import 'package:nch/screens/loading_screen.dart';
import 'package:provider/provider.dart';




void main() {
runApp(const HymnalApp());
}


class HymnalApp extends StatelessWidget {
const HymnalApp({Key? key}) : super(key: key);


@override
Widget build(BuildContext context) {
return ChangeNotifierProvider(
create: (_) => HymnalModel(),
child: MaterialApp(
debugShowCheckedModeBanner: false,
title: 'Catholic Hymnal',
theme: ThemeData(
primarySwatch: Colors.teal,
useMaterial3: true,
),
home: const LoadingScreen(),
),
);
}
}