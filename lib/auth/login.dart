import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasksmanager/constants/AppColor.dart';
import 'package:tasksmanager/Home/HomeScreen.dart';
import 'package:tasksmanager/auth/register.dart';
import 'package:tasksmanager/constants/dialog_utils.dart';
import 'package:tasksmanager/firebase_utils.dart';
import 'package:tasksmanager/provider/authProvider.dart';
import 'package:tasksmanager/widgets/auth/customTextFormField.dart';

class Login extends StatefulWidget {
  static String route_Name = "Login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController =
      TextEditingController();

  TextEditingController passwordController =
      TextEditingController();

  bool showPass = false;
  bool obscure = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Stack(children: [
      Container(
        color: AppColor.backgroundColor,
      ),
      SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset(
          "assets/images/background_screen.png",
          fit: BoxFit.fill,
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "Login ",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.23,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Welcome Back !",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColor.darkBackgroundColor,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Customtextformfield(
                    isPassword: false,
                    controller: emailController,
                    lableText: "Email",
                    textInputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please Enter Email";
                      }
                      final bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      ).hasMatch(value);
                      if (!emailValid) {
                        return "Enter a Valid Email";
                      }

                      return null;
                    },
                  ),
                  Customtextformfield(
                    isPassword: true,
                    isShown: showPass,
                    controller: passwordController,
                    lableText: "Password",
                    obscureText: obscure,
                    textInputType: TextInputType.text,
                    onIconPressed: () {
                      if (showPass == false || obscure == true) {
                        showPass = true;
                        obscure = false;
                      } else {
                        obscure = true;
                        showPass = false;
                      }
                      setState(() {});
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please Enter Password";
                      } else if (value.length < 6) {
                        return "Password Must be 6 cahrs. or more.";
                      }

                      return null;
                    },
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forget Password ?",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.black45),
                    ),
                  ),
                  Container(
                    width: width,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: AppColor.primaryLightColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: MaterialButton(
                      onPressed: onLogin,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Login",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(Register.route_Name);
                    },
                    child: Text(
                      "Create New Account",
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.black45),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    ]);
  }

  void onLogin() async {
    if (formKey.currentState!.validate() == true) {
      DialogUtils.showLoadingDialog(context, "Loading ...");
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        var authProvider = Provider.of<Authprovider>(context, listen: false);

        var user = await FirebaseUtils.readUserfromFireStore(
          credential.user?.uid ?? "",
        );
        if (user == null) {
          return;
        }
        authProvider.updateUser(user);
        DialogUtils.hideLoading(context);

        DialogUtils.showMessage(
          context: context,
          title: "Success",
          content: "Login Successfully",
          postActionNamed: "OK",
          posaction: () {
            Navigator.of(context).pushReplacementNamed(HomeScreen.route_Name);
          },
        );

        print("Login Successfully");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          DialogUtils.hideLoading(context);

          DialogUtils.showMessage(
              context: context,
              content: "No user found for that email.",
              postActionNamed: "Ok");
          print('No user found for that email.');
        } else if (e.code == "network-request-failed") {
          DialogUtils.hideLoading(context);

          DialogUtils.showMessage(
              context: context,
              content: "Check your Internet Connection.",
              postActionNamed: "Ok");
        }
      } 
      //catch (e) {
      //   DialogUtils.hideLoading(context);

      //   DialogUtils.showMessage(
      //     context: context,
      //     content: e.toString(),
      //   );
      //   print(e.toString());
      // }
    }
  }
}
