import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nch/models/hymn.dart';


class HymnalModel extends ChangeNotifier {
List<Hymn> _hymns = [];
List<Hymn> get hymns => _hymns;


List<int> _favorites = [];
Set<int> get favoriteSet => _favorites.toSet();


String _query = '';
String get query => _query;


double _textScale = 1.0;
double get textScale => _textScale;


bool _showFavoritesOnly = false;
bool get showFavoritesOnly => _showFavoritesOnly;


Future<void> loadFromAssets(String assetPath) async {
final raw = await rootBundle.loadString(assetPath);
final data = json.decode(raw) as List<dynamic>;
_hymns = data.map((e) => Hymn.fromJson(e as Map<String, dynamic>)).toList();
_hymns.sort((a, b) => a.number.compareTo(b.number));
await _loadPrefs();
notifyListeners();
}


void setQuery(String q) {
_query = q;
notifyListeners();
}


List<Hymn> get filtered {
final q = _query.trim().toLowerCase();
var list = _hymns;
if (_showFavoritesOnly) list = list.where((h) => _favorites.contains(h.number)).toList();
if (q.isEmpty) return list;
return list.where((h) {
return h.title.toLowerCase().contains(q) ||
h.firstLine.toLowerCase().contains(q) ||
h.lyrics.toLowerCase().contains(q) ||
h.number.toString() == q;
}).toList();
}


void toggleFavorite(int hymnNumber) async {
if (_favorites.contains(hymnNumber)) {
_favorites.remove(hymnNumber);
} else {
_favorites.add(hymnNumber);
}
notifyListeners();
await _savePrefs();
}


void setShowFavoritesOnly(bool v) {
_showFavoritesOnly = v;
notifyListeners();
}


void setTextScale(double s) {
_textScale = s.clamp(0.8, 2.5);
notifyListeners();
_savePrefs();
}


Future<void> _loadPrefs() async {
final sp = await SharedPreferences.getInstance();
final fav = sp.getStringList('favorites') ?? [];
_favorites = fav.map(int.parse).toList();
_textScale = sp.getDouble('textScale') ?? 1.0;
}


Future<void> _savePrefs() async {
final sp = await SharedPreferences.getInstance();
final fav = _favorites.map((e) => e.toString()).toList();
await sp.setStringList('favorites', fav);
await sp.setDouble('textScale', _textScale);
}
}