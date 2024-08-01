import 'package:flutter/material.dart';
import 'package:tutorial_2/shared/loading.dart';
import '../../Services/auth.dart';
class Register extends StatefulWidget {
  final toggleView;
  const Register({Key? key,this.toggleView}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  // text field state

  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/ocean.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0),
              BlendMode.darken,
            ),
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 30,),
                  Text(
                    'New Here..?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Lora',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 30,),
                  Text(
                    'Register Now',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 40,
                      fontFamily: 'Anton',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(
                        Icons.email,
                      color: Colors.amber,
                    ),
                    hintText: 'Email',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        )
                    )
                ),
                validator: (val) => val!.isEmpty? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(
                        Icons.lock_open,
                      color: Colors.black87,
                    ),
                    hintText: 'Password',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        )
                    )
                ),
                validator: (val) => val!.length < 6? 'Enter a password 6+ char long' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.pink.shade500)
                ),
                child: Text(
                  '    Register    ',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async{
                  if (_formKey.currentState!.validate()){
                    setState(() {
                      loading=true;
                    });
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        error = 'please supply a valid email';
                        loading=false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 12),
              Text(
                error,
                style: TextStyle(color: Colors.red,fontSize: 14),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have already an account?",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 16
                  ),),
                  TextButton(
                    child: Text(
                      'Sign In',
                      style:TextStyle(
                          color: Colors.green[500]
                      ) ,
                    ),
                    onPressed: (){widget.toggleView();},
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
