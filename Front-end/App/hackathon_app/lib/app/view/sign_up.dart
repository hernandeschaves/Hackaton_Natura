import 'package:flutter/material.dart';
import '../services/auth.dart';
import '../../main.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  bool _isHidden = true;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthService _auth = AuthService();

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _setLoading() {
    setState(() {
      loading = !loading;
    });
  }

  setName(String name) {
    userController.setFormName(name);
  }

  setEmail(String email) {
    userController.setFormEmail(email);
  }

  setPassword(String password) {
    userController.setFormPassword(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          'Registre-se',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xffff8a4d),
      ),
      backgroundColor: Color(0xffffbb7b),
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 80,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      buildTextField("Nome"),
                      SizedBox(
                        height: 20.0,
                      ),
                      buildTextField("Email"),
                      SizedBox(
                        height: 20.0,
                      ),
                      buildTextField('Senha'),
                      SizedBox(
                        height: 40.0,
                      ),
                      buildButtonContainer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String hintText) {
    return TextFormField(
      controller: TextEditingController(
        text: hintText == "Email"
            ? userController.formEmail
            : hintText == "Nome"
                ? userController.formName
                : userController.formPassword,
      ),
      style: TextStyle(color: Colors.black),
      validator: (value) {
        if (value.isEmpty) {
          return hintText == "Email"
              ? 'Digite um email'
              : hintText == "Nome"
                  ? 'Digite um nome'
                  : 'Digite um senha';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Color(0xffc75b20)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffc75b20),
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIcon: hintText == "Email"
            ? Icon(
                Icons.email,
                color: Color(0xffc75b20),
              )
            : hintText == "Nome"
                ? Icon(
                    Icons.person,
                    color: Color(0xffc75b20),
                  )
                : Icon(
                    Icons.lock,
                    color: Color(0xffc75b20),
                  ),
        suffixIcon: hintText == 'Senha'
            ? IconButton(
                onPressed: _toggleVisibility,
                icon: _isHidden
                    ? Icon(
                        Icons.visibility_off,
                        color: Color(0xffc75b20),
                      )
                    : Icon(
                        Icons.visibility,
                        color: Color(0xffc75b20),
                      ),
              )
            : null,
      ),
      obscureText: hintText == 'Senha' ? _isHidden : false,
      onChanged: (value) => {
        hintText == "Email"
            ? setEmail(value)
            : hintText == "Nome"
                ? setName(value)
                : setPassword(value)
      },
    );
  }

  Widget buildButtonContainer() {
    //ProgressDialog pr = ProgressDialog(context, isDismissible: true);
    return Container(
      height: 56.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23.0),
        color: Color(0xffc75b20),
      ),
      child: Container(
        child: FlatButton(
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              //Show CircularProgress
              _setLoading();
              //Create user
              var res = await _auth.signUpWithEmail();
              _setLoading();
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text(
                    res.contains('cadastrado')
                        ? "Usuário cadastrado com sucesso"
                        : res.contains('already in use')
                            ? "E-mail já cadastrado"
                            : res.contains('Password')
                                ? "Senha deve ter no mínimo 6 caracteres"
                                : "E-mail com formato inválido",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  action: SnackBarAction(
                    label: 'Fechar',
                    onPressed: () {},
                    textColor: Colors.black,
                  ),
                  backgroundColor: Color(0xffc75b20),
                ),
              );
              /* Navigator.pushNamed(
                context,
                '/login',
              ); */
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (loading)
                Row(
                  children: [
                    Text(
                      "Registre-se",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                  ],
                ),
              if (!loading)
                Text(
                  "Registre-se",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
            ],
          ),
          color: Colors.transparent,
        ),
      ),
    );
  }
}
