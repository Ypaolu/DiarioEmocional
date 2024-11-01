import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class User {
  String name;
  String email;
  String password;
  String phone;

  User(
      {required this.name,
      required this.email,
      required this.password,
      required this.phone});
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  List<User> users = []; // Lista de usuários

  void _login() {
    final email = _emailController.text;
    final password = _passwordController.text;

    for (var user in users) {
      if (user.email == email && user.password == password) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home(user: user)),
        );
        return;
      }
    }

    // Exibir mensagem de erro se o login falhar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Email ou senha incorretos')),
    );
  }

  void _goToCreateAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateAccount(users: users)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFEB5E7F),
                Color(0xFFF98F6F),
                Color(0xFFDBBF6B),
                Color(0xFF9C8680),
              ],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.api,
                    size: 50,
                    color: null,
                  ),
                  SizedBox(height: 20),
                  ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFEB5E7F),
                              Color(0xFFF98F6F),
                              Color(0xFFDBBF6B),
                              Color(0xFFC8EB6A),
                              Color(0xFF9C8680),
                            ],
                          ).createShader(
                            bounds,
                          ),
                      child: Stack(
                        children: <Widget>[
                          // Stroked text as border.
                          Text(
                            'Diário\nEmocional',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 65,
                              fontFamily: ' ',
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 10
                                ..color = const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          // Solid text as fill.
                          Text(
                            'Diário\nEmocional',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 65,
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      )),
                  SizedBox(height: 20),
                  Icon(
                    Icons.api,
                    size: 50,
                    color: null,
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 250, // tamanho do campo de texto
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'EMAIL',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 250, // tamanho do campo de texto
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'SENHA',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: _toggleObscureText,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  Container(
                    width: 200, // largura do botão
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFEB5E7F),
                          Color(0xFFF98F6F),
                          Color(0xFFDBBF6B),
                          Color(0xFFC8EB6A),
                          Color(0xFF9C8680),
                        ],
                      ),
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: _login,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'LOGIN',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: _goToCreateAccount,
                    child: Text(
                      'CRIAR CONTA',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Icon(
                    Icons.api,
                    size: 50,
                    color: null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CreateAccount extends StatelessWidget {
  final List<User> users;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  CreateAccount({required this.users});

  void _createAccount(BuildContext context) {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final phone = _phoneController.text;

    if (name.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        phone.isNotEmpty) {
      users.add(
          User(name: name, email: email, password: password, phone: phone));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home(user: users.last)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECA38F),
      appBar: AppBar(
          title: Text(
            'SEJA BEM-VINDO(A)!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFFEB5E7F),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.keyboard_return_sharp))
          ]),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [
                Color(0xFFEB5E7F),
                Color(0xFFF98F6F),
              ],
            ),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 100),
                Container(
                    foregroundDecoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFDBBF6B), width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: 425,
                    height: 600,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFEB5E7F),
                          Color(0xFFF98F6F),
                        ],
                      ),
                    ),
                    child: Column(children: <Widget>[
                      Align(alignment: Alignment.center),
                      SizedBox(height: 20),
                      Text(
                        "COMO PREFERE SER CHAMADO(A)?",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 270, // tamanho do campo de texto
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Digite aqui...',
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "QUAL SEU EMAIL?",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 270, // tamanho do campo de texto
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Digite aqui...',
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "DIGITE SUA SENHA",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 270, // tamanho do campo de texto
                        child: TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Digite aqui...',
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "QUAL SEU NÚMERO DE TELEFONE?",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 270, // tamanho do campo de texto
                        child: TextField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Digite aqui...',
                          ),
                        ),
                      ),
                      SizedBox(height: 60),
                      Container(
                        width: 200, // largura do botão
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFEB5E7F),
                              Color(0xFFF98F6F),
                              Color(0xFFDBBF6B),
                              Color(0xFFC8EB6A),
                              Color(0xFF9C8680),
                            ],
                          ),
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextButton(
                          onPressed: () => _createAccount(context),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'CRIAR CONTA',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  final User user;
  const Home({super.key, required this.user});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, String>> _emotions = [];
  final TextEditingController _descriptionController = TextEditingController();
  List<String> _happyEmojis = ['😊', '😃', '😁']; // Feliz
  List<String> _neutralEmojis = ['😐', '😨', '🤡']; // Outros
  List<String> _sadEmojis = ['🙁', '😢', '😭']; // Triste

  String _selectedEmoji = '';
  int _happyIndex = 0;
  int _neutralIndex = 0;
  int _sadIndex = 0;

  void _addEmotion() {
    final newEmotion = {
      'data': DateFormat('dd/MM/yyyy').format(DateTime.now()),
      'hora': DateFormat('HH:mm').format(DateTime.now()),
      'emocoes': _selectedEmoji,
      'nota': _descriptionController.text,
    };
    setState(() {
      _emotions.add(newEmotion);
      _descriptionController.clear();
      _selectedEmoji = '';
    });
  }

  void _changeEmoji(String emotionType) {
    setState(() {
      if (emotionType == 'feliz') {
        _happyIndex = (_happyIndex + 1) % _happyEmojis.length;
        _selectedEmoji = _happyEmojis[_happyIndex];
      } else if (emotionType == 'outro') {
        _neutralIndex = (_neutralIndex + 1) % _neutralEmojis.length;
        _selectedEmoji = _neutralEmojis[_neutralIndex];
      } else if (emotionType == 'triste') {
        _sadIndex = (_sadIndex + 1) % _sadEmojis.length;
        _selectedEmoji = _sadEmojis[_sadIndex];
      }
    });
  }

  void _delete() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => Login()), //Leva para a tela de login
    );
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: Color(0xFFECA38F),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('OLÁ, ${widget.user.name}'),
        centerTitle: true,
        backgroundColor: Color(0xFFEB5E7F),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => Login()), // Página Home
              );
            },
            icon: Icon(Icons.door_back_door, size: 30, color: Colors.black),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Container(
              foregroundDecoration: BoxDecoration(
                border: Border.all(color: Color(0xFFDBBF6B), width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              width: 425,
              height: 460,
              color: Color(0xFFFE9B80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Como você está se sentindo?',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.alarm),
                      SizedBox(width: 10),
                      Text(
                        DateFormat('HH:mm').format(DateTime.now()),
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 1,
                        height: 20,
                        color: Colors.black,
                      ),
                      Icon(Icons.calendar_month),
                      Text(currentDate),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        hoverElevation: 0,
                        highlightElevation: 0,
                        onPressed: () => _changeEmoji('feliz'),
                        child: Text(
                          _happyEmojis[_happyIndex],
                          style: TextStyle(fontSize: 45, color: Colors.black),
                        ),
                      ),
                      FloatingActionButton(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        hoverElevation: 0,
                        highlightElevation: 0,
                        onPressed: () => _changeEmoji('outro'),
                        child: Text(
                          _neutralEmojis[_neutralIndex],
                          style: TextStyle(fontSize: 45, color: Colors.black),
                        ),
                      ),
                      FloatingActionButton(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        hoverElevation: 0,
                        highlightElevation: 0,
                        onPressed: () => _changeEmoji('triste'),
                        child: Text(
                          _sadEmojis[_sadIndex],
                          style: TextStyle(fontSize: 45, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Descreva como você está se sentindo',
                            ),
                            maxLines: 4,
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            _selectedEmoji,
                            style: TextStyle(fontSize: 80),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 22),
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFEB5E7F),
                          Color(0xFFF98F6F),
                          Color(0xFFDBBF6B),
                          Color(0xFFC8EB6A),
                          Color(0xFF9C8680),
                        ],
                      ),
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (_descriptionController.text.isNotEmpty) {
                          _addEmotion();
                        }
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'ADICIONAR',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
            Container(
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => History(
                        emotions: _emotions,
                        onDelete: (index) {
                          setState(() {
                            _emotions.removeAt(index);
                          });
                        },
                        onEdit: (index, newEmotion, _) {
                          if (mounted) {
                            setState(() {
                              _emotions[index] =
                                  newEmotion as Map<String, String>;
                            });
                          }
                        },
                      ),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Color(0xFFC8EB6A),
                ),
                child: Text(
                  'HISTÓRICO',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 60),
            Container(
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfiguracoesPage(
                        user: widget.user,
                        onDelete: _delete,
                        onEdit: (field, newValue) {
                          setState(() {
                            if (field == 'name') {
                              widget.user.name = newValue;
                            } else if (field == 'email') {
                              widget.user.email = newValue;
                            } else if (field == 'password') {
                              widget.user.password = newValue;
                            } else if (field == 'phone') {
                              widget.user.phone = newValue;
                            }
                          });
                        },
                      ),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Color(0xFFDBBF6B),
                ),
                child: Text(
                  'CONFIGURAÇÕES',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class History extends StatelessWidget {
  final List<Map<String, String>> emotions;
  final Function(int) onDelete; // Adicionando a função de deletar
  final Function(int, String, String) onEdit; // Adicionando a função de edição

  const History(
      {super.key,
      required this.emotions,
      required this.onDelete,
      required this.onEdit});

  @override
  Widget build(BuildContext context) {
    Map<String, Map<String, List<Map<String, String>>>> groupedEmotions = {};

    for (var emotion in emotions) {
      String date = emotion['data']!;
      String time = emotion['hora']!;
      if (!groupedEmotions.containsKey(date)) {
        groupedEmotions[date] = {};
      }
      if (!groupedEmotions[date]!.containsKey(time)) {
        groupedEmotions[date]![time] = [];
      }
      groupedEmotions[date]![time]!.add(emotion);
    }

    return Scaffold(
      backgroundColor: Color(0xFFECA38F),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon:
              Icon(Icons.keyboard_return_sharp, size: 30, color: Colors.black),
        ),
        title: Text("HISTÓRICO EMOCIONAL"),
        centerTitle: true,
        backgroundColor: Color(0xFFEB5E7F),
      ),
      body: ListView(
        children: groupedEmotions.entries.map((dateEntry) {
          String date = dateEntry.key;
          var timeEntries = dateEntry.value.entries.toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  date,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              ...timeEntries.map((timeEntry) {
                String time = timeEntry.key;
                var emotionsList = timeEntry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        time,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...emotionsList.asMap().entries.map((emotionEntry) {
                      int index = emotionEntry.key;
                      var emotion = emotionEntry.value;
                      return ListTile(
                        title: Text(emotion['emocoes']!),
                        subtitle: Text(emotion['nota']!),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.black),
                              onPressed: () {
                                _showEditDialog(context, index, emotion);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.black),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Excluir Registro'),
                                      content: Text(
                                          'Você tem certeza que deseja excluir este registro?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            onDelete(index);
                                            Navigator.of(context)
                                                .pop(); // Fecha o diálogo
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      "Registro excluído")),
                                            );
                                          },
                                          child: Text('Sim'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Fecha o diálogo
                                          },
                                          child: Text('Não'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                );
              }).toList(),
            ],
          );
        }).toList(),
      ),
    );
  }

  void _showEditDialog(
      BuildContext context, int index, Map<String, String> emotion) {
    final TextEditingController _noteController =
        TextEditingController(text: emotion['nota']);
    final TextEditingController _emotionController =
        TextEditingController(text: emotion['emocoes']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFEB5E7F),
          title: Text('EDITAR REGISTRO'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _emotionController,
                decoration: InputDecoration(hintText: "Nova Emoção"),
              ),
              TextField(
                controller: _noteController,
                decoration: InputDecoration(
                    hintText: "DESCREVA COMO ESTAVA SE SENTINDO"),
                maxLines: 4,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_noteController.text.isNotEmpty &&
                    _emotionController.text.isNotEmpty) {
                  onEdit(index, _emotionController.text, _noteController.text);
                  Navigator.of(context).pop();
                }
              },
              child: Text('SALVAR',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  )),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('CANCELAR',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  )),
            ),
          ],
        );
      },
    );
  }
}

class ConfiguracoesPage extends StatelessWidget {
  final User user;
  final Function onDelete; // Callback para logout
  final Function(String, String) onEdit; // Adicionando callback para editar

  ConfiguracoesPage(
      {required this.user, required this.onDelete, required this.onEdit});

  void _showEditDialog(BuildContext context, String field) {
    final TextEditingController _controller = TextEditingController();

    switch (field) {
      case 'name':
        _controller.text = user.name;
        break;
      case 'email':
        _controller.text = user.email;
        break;
      case 'password':
        _controller.text = user.password;
        break;
      case 'phone':
        _controller.text = user.phone;
        break;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFEB5E7F),
          title: Text('DIGITE A NOVA INFORMAÇÃO'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "Digite a nova informação"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  onEdit(field, _controller.text); // Chama a função de editar
                  Navigator.of(context).pop(); // Fecha o diálogo
                }
              },
              child: Text('Salvar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECA38F),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon:
              Icon(Icons.keyboard_return_sharp, size: 30, color: Colors.black),
        ),
        title: const Text('CONFIGURAÇÕES'),
        centerTitle: true,
        backgroundColor: Color(0xFFEB5E7F),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'APELIDO',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFF88B70),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  user.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _showEditDialog(context, 'name');
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'EMAIL',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFF88B70),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  user.email,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _showEditDialog(context, 'email');
                  },
                ),
              ],
            ),
          ),
          Padding(
  padding: const EdgeInsets.all(10),
  child: Text(
    'SENHA',
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  ),
),
Container(
  margin: EdgeInsets.all(10),
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Color(0xFFF88B70),
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 4,
        offset: Offset(2, 2),
      ),
    ],
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // Use TextField para mostrar a senha como texto oculto
      SizedBox(
        width: 200, // Ajuste a largura conforme necessário
        child: TextField(
          controller: TextEditingController(text: user.password), // Controlador para a senha
          obscureText: true, // Oculta o texto
          readOnly: true, // Torna o campo apenas leitura
          decoration: InputDecoration(
            border: InputBorder.none, // Remove a borda
          ),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          _showEditDialog(context, 'password');
        },
      ),
    ],
  ),
),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'NÚMERO DE TELEFONE',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFF88B70),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  user.phone,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _showEditDialog(context, 'phone');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
