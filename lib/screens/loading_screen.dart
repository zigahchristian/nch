import 'package:flutter/material.dart';
import 'package:nch/providers/hymnal_model.dart';
import 'package:nch/screens/home_page.dart';
import 'package:provider/provider.dart';



class LoadingScreen extends StatefulWidget {
const LoadingScreen({Key? key}) : super(key: key);


@override
State<LoadingScreen> createState() => _LoadingScreenState();
}


class _LoadingScreenState extends State<LoadingScreen> {
@override
void initState() {
super.initState();
_init();
}


Future<void> _init() async {
final model = Provider.of<HymnalModel>(context, listen: false);
await model.loadFromAssets('assets/the_new_catholic_hymnal.json');
Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
}


@override
Widget build(BuildContext context) {
return const Scaffold(
body: Center(child: CircularProgressIndicator()),
);
}
}