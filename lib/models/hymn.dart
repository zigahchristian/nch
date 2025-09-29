class Hymn {
final int number;
final String title;
final String firstLine;
final String lyrics;
final String author;
final String composer;


Hymn({
required this.number,
required this.title,
required this.firstLine,
required this.lyrics,
required this.author,
required this.composer,
});


factory Hymn.fromJson(Map<String, dynamic> j) => Hymn(
number: j['number'] as int,
title: j['title'] ?? '',
firstLine: j['first_line'] ?? '',
lyrics: j['lyrics'] ?? '',
author: j['author'] ?? 'Unknown',
composer: j['composer'] ?? 'Traditional',
);
}