// lib/screens/search_screen.dart
import 'package:flutter/material.dart';
import 'package:nch/providers/hymnal_model.dart';
import 'package:nch/screens/hymnal_detail_page.dart';
import 'package:provider/provider.dart';


class HomePage extends StatelessWidget {
const HomePage({super.key});

@override
Widget build(BuildContext context) {
final model = Provider.of<HymnalModel>(context);
return Scaffold(
appBar: AppBar(
title: const Text('The New Catholic Hymnal'),
actions: [
IconButton(
icon: Icon(model.showFavoritesOnly ? Icons.favorite : Icons.favorite_border),
onPressed: () => model.setShowFavoritesOnly(!model.showFavoritesOnly),
tooltip: 'Toggle favorites',
),

],
),
body: Column(
children: [
Padding(
padding: const EdgeInsets.all(8.0),
child: TextField(
onChanged: (v) => model.setQuery(v),
decoration: const InputDecoration(
prefixIcon: Icon(Icons.search),
hintText: 'Search by title, first line, text or number',
border: OutlineInputBorder(),
),
),
),
Expanded(
child: Consumer<HymnalModel>(builder: (context, m, _) {
final list = m.filtered;
if (list.isEmpty) {
return const Center(child: Text('No hymns found'));
}
return ListView.builder(
itemCount: list.length,
itemBuilder: (context, idx) {
final h = list[idx];
final fav = m.favoriteSet.contains(h.number);
return ListTile(
title: Text('${h.number}. ${h.title}'),
trailing: IconButton(
icon: Icon(fav ? Icons.favorite : Icons.favorite_border, color: fav ? Colors.red : null),
onPressed: () => m.toggleFavorite(h.number),
),
onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => HymnDetailPage(hymn: h))),
);
},
);
}),
),
],
),
);
}
}