import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bus_driver/edit_profile_page/edit_profile_page.dart';
import 'package:vroom_core/models/app_state.dart';
import 'package:bus_driver/screens/about_page/about_page.dart';
import 'package:vroom_core/widgets/custom_button.dart';
import 'package:vroom_core/widgets/heading_text.dart';
import 'package:provider/provider.dart';
import 'package:vroom_core/widgets/profile_image.dart';



class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Row(
              children: [
                IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.chevron_left)
                ),
                const Spacer(),
                const HeadingText("Profile"),
                const Spacer(),
              ],
            ),


            ProfileImage(image: context.read<AppState>().auth!.currentUser!.photoURL),

            HeadingText(context.read<AppState>().auth!.currentUser!.displayName!),

            CustomButton(
                text: "LOG OUT",
                onPressed: (){
                  FirebaseAuth auth = FirebaseAuth.instance;
                  auth.signOut();
                }),

            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Edit Profile"),
              trailing: const Icon(Icons.chevron_right),
              onTap: (){
                User user = context.read<AppState>().auth!.currentUser!;

                Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=> EditProfilePage(
                      email: user.email!,
                      name: user.displayName!,
                    )
                    )
                );
              },
            ),

            const ListTile(
              leading: Icon(Icons.notifications_outlined),
              title: Text("Notifications"),
              trailing: Icon(Icons.chevron_right),
            ),

            const ListTile(
              leading: Icon(Icons.bug_report_outlined),
              title: Text("Report a problem"),
              trailing: Icon(Icons.chevron_right),
            ),

            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About"),
              trailing: const Icon(Icons.chevron_right),
              onTap: (){
                Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=> const AboutPage()
                    )
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
