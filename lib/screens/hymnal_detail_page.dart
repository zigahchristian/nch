import 'package:flutter/material.dart';
import 'package:nch/models/hymn.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:nch/providers/hymnal_model.dart';



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
icon: const Icon(Icons.share),
onPressed: () => Share.share('${hymn.title}\n\n${hymn.lyrics}'),
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
Text('Author: ${hymn.author} • Composer: ${hymn.composer}', style: Theme.of(context).textTheme.bodySmall, textScaleFactor: model.textScale),
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