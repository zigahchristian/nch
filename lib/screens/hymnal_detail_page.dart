import 'package:flutter/material.dart';
import 'package:nch/models/hymn.dart';
import 'package:provider/provider.dart';
import 'package:nch/providers/hymnal_model.dart';
import 'package:nch/screens/settings_sheet.dart';



class HymnDetailPage extends StatelessWidget {
final Hymn hymn;
const HymnDetailPage({super.key, required this.hymn});


@override
Widget build(BuildContext context) {
final model = Provider.of<HymnalModel>(context);
final isFav = model.favoriteSet.contains(hymn.number);
return Scaffold(
appBar: AppBar(
title: Text('${hymn.number}. ${hymn.title}'),
actions: [
IconButton(
icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? Colors.red : null),
onPressed: () => model.toggleFavorite(hymn.number),
),
IconButton(
icon: const Icon(Icons.settings),
onPressed: () => showModalBottomSheet(context: context, builder: (_) => const SettingsSheet()),
tooltip: 'Settings',
),
],
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: SingleChildScrollView(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(hymn.firstLine, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold), textScaleFactor: model.textScale),
const SizedBox(height: 12),
const SizedBox(height: 12),
SelectableText(hymn.lyrics, style: Theme.of(context).textTheme.bodyMedium, textScaleFactor: model.textScale),
const SizedBox(height: 20),
],
),
),
),
);
}
}