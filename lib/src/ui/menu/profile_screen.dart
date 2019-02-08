import 'package:diary_of_teacher/src/app.dart';
import 'package:diary_of_teacher/src/models/user.dart';
import 'package:diary_of_teacher/src/ui/menu/drawer.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileScreen extends StatefulWidget {
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _controller;
  bool isEditing = false;
  final _key = GlobalKey<FormState>();
  FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: User.user.userName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Мой профиль'),
          centerTitle: true,
        ),
        drawer: MenuDrawer(),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 200.0,
                          child: Center(
                            child: CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                  User.user.photoUrl),
                              radius: 100,
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    print('Button tapped');
                                  },
                                  iconSize: 80.0,
                                  color: Colors.white70,
                                  icon: Icon(Icons.camera_alt),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 30.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Form(
                                  key: _key,
                                  child: TextFormField(
                                    focusNode: _focus,
                                    textAlign: TextAlign.center,
                                    controller: _controller,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      hintText: 'Введите имя',
                                    ),
                                    enabled: isEditing,
                                    style: theme.textTheme.body1,
                                    validator: (value) {
                                      if (value.length == 0)
                                        return 'Имя не должно быть пустым';
                                    },
                                  ),
                                ),
                              ),
                              IconButton(
                                color: Color(0xFFFFBED0),
                                icon: Icon(isEditing ? Icons.done : Icons.edit),
                                onPressed: () {
                                  if (isEditing && complete()) {
                                    setState(() {
                                      isEditing = !isEditing;
                                    });
                                    return;
                                  }
                                  if (!isEditing) {
                                    startEdit();
                                    setState(() {
                                      isEditing = !isEditing;
                                    });
                                    return;
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )));
  }

  bool complete() {
    if (_key.currentState.validate()) return true;
    return false;
  }

  void startEdit() {
    FocusScope.of(context).requestFocus(_focus);
  }
}
