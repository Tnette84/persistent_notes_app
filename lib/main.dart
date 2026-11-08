import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});


    @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  Future<void> _saveThemePreference(bool value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isDarkMode', value);
}

Future<void> _loadThemePreference() async {
  final prefs = await SharedPreferences.getInstance();

  setState(() {
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
  });
}
@override
void initState() {
  super.initState();
  _loadThemePreference();
}
void _toggleDarkMode(bool value) {
  setState(() {
    _isDarkMode = value;
  });

  _saveThemePreference(value);
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
     theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: MyHomePage(
  title: 'Persistent Notes App',
  isDarkMode: _isDarkMode,
  onThemeChanged: _toggleDarkMode,
),
    );
  }
}



  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
class MyHomePage extends StatefulWidget {
   const MyHomePage({
    super.key,
    required this.title,
    required this.isDarkMode,
    required this.onThemeChanged,
  }); 
  final String title;
 final bool isDarkMode;
final ValueChanged<bool> onThemeChanged; 

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 final TextEditingController _noteController = TextEditingController();

Future<void> _saveNote() async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/notes.txt');

  await file.writeAsString(_noteController.text);

  debugPrint('Note saved successfully!');
  debugPrint(await file.readAsString());
}

@override
void dispose() {
  _noteController.dispose();
  super.dispose();
} 
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      bottomNavigationBar: SwitchListTile(
  title: const Text('Dark Mode'),
  value: widget.isDarkMode,
  onChanged: widget.onThemeChanged,
),
  body: Padding(
  padding: const EdgeInsets.all(16.0),
  child: Column(
    children: [
      TextField(
        controller: _noteController,
        maxLines: 5,
        decoration: const InputDecoration(
          labelText: 'Enter your note',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 16),
      ElevatedButton(
        onPressed: _saveNote,
        child: const Text('Save Note'),
      ),
    ],
  ),
),   
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
