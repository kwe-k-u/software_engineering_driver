
import "package:flutter/material.dart";
import 'package:vroom_core/models/app_state.dart';
import 'package:bus_driver/screens/login_screen/login_screen.dart';
import 'package:vroom_core/widgets/curved_background.dart';
import 'package:vroom_core/widgets/custom_button.dart';
import 'package:vroom_core/widgets/custom_text_field.dart';
import 'package:vroom_core/widgets/heading_text.dart';
import 'package:vroom_core/widgets/input_section.dart';
import 'package:provider/provider.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
        
    return CurvedBackground(
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height * 0.83,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const HeadingText("Sign Up"),
                const Spacer(flex: 3,),
                InputSection(
                    inputs: [
                      CustomTextField(
                        controller: name,
                        hintText: "Full Name",
                      ),

                      CustomTextField(
                        controller: email,
                        hintText: "someone@ashesi.edu.gh",
                        icon: Icons.account_circle_outlined,
                        validator: (e){
                          if (email.text.endsWith("@ashesi.edu.gh")){
                            return "";
                          }
                          return "Only ashesi emails are accepted";
                        },
                      ),

                      CustomTextField(
                        controller: password,
                        hintText: "Password",
                        obscureText: true,
                        icon: Icons.lock_outline,
                      ),

                      CustomTextField(
                        controller: cPassword,
                        hintText: "Confirm Password",
                        icon: Icons.lock_outline,
                        obscureText: true,
                      ),

                    ]),

                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.info),
                    const Text("This app is only for\nAshesi bus drivers"),
                    CustomButton(text: "Create Account", onPressed: (){

                      context.read<AppState>().signup(email: email.text, name: name.text, password: password.text);

                    })
                  ],
                ),
                const Spacer(),
                const Text("Already have an account?"),

                TextButton(onPressed: (){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context)=> const LoginScreen()
                      )
                  );
                }, child: const Text("Sign In"))
              ],
            ),
          ),
        )
    );
  }
}
