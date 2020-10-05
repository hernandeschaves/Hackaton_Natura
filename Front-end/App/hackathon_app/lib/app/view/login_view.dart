import 'package:flutter/material.dart';
import 'package:hackathon_app/app/services/auth.dart';
import 'package:hackathon_app/main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isHidden = true;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
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

  /* setEmail(String email) {
    setState(() {
      this.email = email;
    });
  }

  setPassword(String password) {
    setState(() {
      this.password = password;
    });
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffbb7b),
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'lib/app/assets/iconNatura.png',
                  width: 150,
                ),
                Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 40.0,
                          ),
                          buildTextField("Email"),
                          SizedBox(
                            height: 20.0,
                          ),
                          buildTextField('Senha'),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(23.0),
                              color: Color(0xffffbb7b),
                            ),
                            child: FlatButton(
                              child: Text(
                                'Esqueceu a senha?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                /* ProgressDialog pr =
                              ProgressDialog(context, isDismissible: true);
                          if (states.email != "") {
                            pr.show();
                            _auth.resetPassword().then((value) => {
                                  if (value == true)
                                    {
                                      pr.hide(),
                                      Get.snackbar(
                                        language['success'],
                                        language['sendEmail'],
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.white,
                                      )
                                    }
                                  else
                                    {
                                      pr.hide(),
                                      Get.snackbar(
                                        'Error',
                                        value.toString(),
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.white,
                                      )
                                    }
                                });
                          } else {
                            Get.snackbar(
                              'Error',
                              language['fillInEmail'],
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.white,
                            );
                          } */
                              },
                              color: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50.0),
                    buildButtonContainer(),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Ainda não tem conta? ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(23.0),
                                color: Color(0xffffbb7b),
                              ),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/signin');
                                },
                                child: Text(
                                  'Registre-se',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                color: Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
              : userController.formPassword,
        ),
        style: TextStyle(color: Colors.black),
        validator: (value) {
          if (value.isEmpty) {
            return hintText == "Email"
                ? 'Digite seu email'
                : 'Digite sua senha';
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
            // width: 0.0 produces a thin "hairline" border
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
                  ? userController.setFormEmail(value)
                  : userController.setFormPassword(value)
            });
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
          onPressed: () {
            // If the form is valid, display a Snackbar.
            if (_formKey.currentState.validate()) {
              // Login user in app
              _setLoading();
              _auth.loginWithEmail().then(
                    (val) => {
                      _setLoading(),
                      if (val == true)
                        {
                          Navigator.pushNamed(context, '/home'),
                          /* Get.snackbar(
                            language['welcome'],
                            language['loginSuccessful'],
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.white,
                          ), */
                        }
                      else
                        {
                          print(val.toString()),
                          /* Get.snackbar(
                            "Login Error",
                            //val.toString(),
                            (val.toString().contains("ERROR_USER_NOT_FOUND"))
                                ? language['userNotFound']
                                : (val
                                        .toString()
                                        .contains("ERROR_WRONG_PASSWORD")
                                    ? language['wrongPassword']
                                    : (val
                                            .toString()
                                            .contains("ERROR_INVALID_EMAIL"))
                                        ? language['invalidEmail']
                                        : 'Login Error'),
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.white,
                          ), */
                        },
                    },
                  );
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (loading)
                Row(
                  children: [
                    Text(
                      "LOGIN",
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
                  "LOGIN",
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
