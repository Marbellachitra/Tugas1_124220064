import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi sederhana',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username == 'user' && password == '333') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Username atau Password salah'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAED2E7), 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome!',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Login untuk mengeksplorasi beranda',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 32),
            Container(
              color: Colors.white,
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              color: Colors.white,
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _login,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 174, 210, 231), 
      appBar: AppBar(title: Text('Beranda')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text('Data Kelompok'),
                  trailing: Icon(Icons.group),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GroupPage()),
                    );
                  },
                ),
              ),
              Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text('Bilangan Ganjil/Genap'),
                  trailing: Icon(Icons.filter_1),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OddEvenPage()),
                    );
                  },
                ),
              ),
              Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text('Penjumlahan/Pengurangan'),
                  trailing: Icon(Icons.add),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MathPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class GroupPage extends StatelessWidget {
  final List<String> members = ['Marbella Chitra (124220064)', 'Hasna Brilian Perdana (124220088)'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Data Kelompok'),
        titleTextStyle: TextStyle(
        fontSize: 16,),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Daftar Anggota Kelompok',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Berikut adalah anggota dari kelompok kami. Anda dapat melihat nama-nama mereka di bawah ini.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blueGrey[600],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(Icons.person, color: Colors.blue),
                      title: Text(
                        members[index],
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      contentPadding: EdgeInsets.all(16),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MathPage extends StatefulWidget {
  @override
  _MathPageState createState() => _MathPageState();
}

class _MathPageState extends State<MathPage> {
  String _expression = '';  
  String _result = '';  
  final _inputController = TextEditingController();

  void _onPressed(String value) {
    setState(() {
      if (value == '⌦') {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
      } else if (value == '=') {
        // Menghitung hasil ekspresi
        try {
          _result = _calculateExpression(_expression).toString();
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _expression += value;
      }
      _inputController.text = _expression;  
    });
  }

  double _calculateExpression(String expression) {
    List<String> tokens = expression.split(RegExp(r'([+-])')); 
    double total = double.parse(tokens[0]);

    int i = 1;
    while (i < tokens.length) {
      String operator = expression[expression.indexOf(tokens[i], expression.indexOf(tokens[i - 1])) - 1];
      double value = double.parse(tokens[i]);

      if (operator == '+') {
        total += value;
      } else if (operator == '-') {
        total -= value;
      }

      i++;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Masukkan angka yang ingin dihitung!'),
        titleTextStyle: TextStyle(
          fontSize: 18,
        ),
        backgroundColor: Color(0xFF90CAF9),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                _expression,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            
            // Display result
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                _result,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('+'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('-'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('⌦'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton('0'),
                    _buildButton('.'), 
                    _buildButton('='),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String value) {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: ElevatedButton(
        onPressed: () => _onPressed(value),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(6.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(221, 19, 
            37, 89),
          ),
        ),
      ),
    );
  }
}


class OddEvenPage extends StatefulWidget {
  @override
  _OddEvenPageState createState() => _OddEvenPageState();
}

class _OddEvenPageState extends State<OddEvenPage> {
  final _numberController = TextEditingController();
  String _result = '';
  String _errorMessage = '';

  void _checkOddEven() {
    setState(() {
      _errorMessage = '';  
      try {
        int number = int.parse(_numberController.text);
        if (number % 2 == 0) {
          _result = '$number adalah Bilangan Genap';
        } else {
          _result = '$number adalah Bilangan Ganjil';
        }
      } catch (e) {
        _errorMessage = 'Input tidak valid. Masukkan angka yang benar.';
        _result = ''; 
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menentukan ganjil/genap'),
        titleTextStyle: TextStyle(
          fontSize: 16,
        ),
        backgroundColor: const Color.fromARGB(255, 248, 248, 252),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 174, 210, 231), Colors.blue.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Cek Bilangan Ganjil atau Genap',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 5, 12, 52),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _numberController,
                decoration: InputDecoration(
                  labelText: 'Masukkan Angka',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              
              if (_errorMessage.isNotEmpty) 
                Text(
                  _errorMessage,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkOddEven,
                child: Text('Cek'),
                style: ElevatedButton.styleFrom(
                  iconColor: const Color.fromARGB(255, 5, 25, 124),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                _result,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 4, 1, 21),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
