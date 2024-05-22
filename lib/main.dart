import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';

void main() {
  enableFlutterDriverExtension();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD App',
      home: MyHomePage(title: 'CRUD App Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textFieldController = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  String? _validateText(String? value) {
    final RegExp regex = RegExp(r'^[a-zA-Z]+$');
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (!regex.hasMatch(value)) {
      return 'Please enter only letters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              key: Key('counter'),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            ElevatedButton(
              key: Key('reset_counter'),
              onPressed: _resetCounter,
              child: Text('Reset Counter'),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      key: Key('textfield'),
                      controller: _textFieldController,
                      decoration: InputDecoration(labelText: 'Enter text'),
                      validator: _validateText,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      key: Key('validate_button'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _showSnackBar('Form is valid!');
                        }
                      },
                      child: Text('Validate'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('increment'),
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
