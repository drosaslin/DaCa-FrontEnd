import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(children: [

            Container(
              padding: EdgeInsets.only(left: 60, top: 60, right: 10, bottom: 0),
              child: Icon(Icons.login),
            ),
            Container(
                padding:
                    EdgeInsets.only(left: 0, top: 60, right: 70, bottom: 0),
                child: Text('Login with account',
                    style: TextStyle(color: Colors.black38))),
          ]),
          Container(
            padding: EdgeInsets.only(left: 70, top: 30, right: 70, bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(decoration: InputDecoration(hintText: 'Account')),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Password'),
                  obscureText: true,
                ),
                // IconButton(icon: Icon(Icons.login_outlined), onPressed: _add),
                // RaisedButton(
                //   child: Text('Login'),
                //   onPressed: _add,
                //   elevation: 10,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // OutlineButton(
                    //   color: Colors.white70,
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(15)),
                    //   child: Text("Login"),
                    //   onPressed: _add,
                    // ),

                    Container(
                      margin: EdgeInsets.only(
                          left: 0, top: 10, right: 15, bottom: 0),
                      child: RaisedButton(
                          color: Color.fromARGB(255, 250, 250, 250),
                          child: Text('Login',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 100, 100, 100))),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          onPressed: _add),
                    ),

                    Container(
                      margin: EdgeInsets.only(
                          left: 15, top: 10, right: 0, bottom: 0),
                      child: RaisedButton(
                        color: Color.fromARGB(255, 250, 250, 250),
                        child: Text('Sign up',
                            style: TextStyle(
                                color: Color.fromARGB(255, 100, 100, 100))),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        onPressed: _add,
                        // padding: EdgeInsets.all(50))
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(left: 0, top: 5, right: 5, bottom: 0),
                      child: RaisedButton(
                          color: Colors.red,
                          child: Text('G+ Google',
                              style: TextStyle(color: Colors.white)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          onPressed: _add),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: 5, top: 5, right: 0, bottom: 0),
                      child: RaisedButton(
                          color: Colors.blueAccent,
                          child: Text('f Facebook',
                              style: TextStyle(color: Colors.white)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          onPressed: _add),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
      backgroundColor: Colors.amber,
    );
  }

  void _add() {}
}

// TextField(
// decoration: InputDecoration(
// contentPadding: const EdgeInsets.all(16.0),
// prefixIcon: Container(
// padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
// margin: const EdgeInsets.only(right: 8.0),
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(30.0),
// bottomLeft: Radius.circular(30.0),
// topRight: Radius.circular(30.0),
// bottomRight: Radius.circular(10.0))),
// child: Icon(
// Icons.person,
// color: Colors.lightGreen,
// )),
// hintText: "enter your email",
// hintStyle: TextStyle(color: Colors.white54),
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(30.0),
// borderSide: BorderSide.none),
// filled: true,
// fillColor: Colors.white.withOpacity(0.1),
// ),
// ),