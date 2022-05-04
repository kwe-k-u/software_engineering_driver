
import "package:flutter/material.dart";
import 'package:vroom_core/models/app_state.dart';
import 'package:bus_driver/screens/signup_screen/signup_screen.dart';
import 'package:bus_driver/widgets/curved_background.dart';
import 'package:bus_driver/widgets/custom_button.dart';
import 'package:bus_driver/widgets/custom_text_field.dart';
import 'package:bus_driver/widgets/heading_text.dart';
import 'package:bus_driver/widgets/input_section.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CurvedBackground(
      marginHeight:  0.25,
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const HeadingText("Login"),
                const Spacer(flex: 2,),
                InputSection(
                    inputs: [

                      CustomTextField(
                          controller: email,
                        hintText: "someone@ashesi.edu.gh",
                        icon: Icons.account_circle_outlined,
                      ),

                      CustomTextField(
                          controller: password,
                        hintText: "Password",
                        obscureText: true,
                        icon: Icons.lock_outline,
                      ),

                    ]),

                // SizedBox(height: 100,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("Forgot your password?"),

                    CustomButton(text: "Log In", onPressed: () async{
                     await context.read<AppState>().auth!.signInWithEmailAndPassword(email: email.text, password: password.text);
                      // Navigator.pushReplacement(context,
                      //     MaterialPageRoute(builder: (context)=> SignupScreen()
                      //     )
                      // );
                    })
                  ],
                ),
                SizedBox(height: 50,),
                Text("Don't have an account?"),
                TextButton(
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> SignupScreen()
                          )
                      );

                    },
                    child: Text("Sign Up"))
                ],
            ),
          ),
        )
    );
  }
}
