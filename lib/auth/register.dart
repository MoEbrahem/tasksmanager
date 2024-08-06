import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasksmanager/Home/HomeScreen.dart';
import 'package:tasksmanager/constants/AppColor.dart';
import 'package:tasksmanager/auth/login.dart';
import 'package:tasksmanager/constants/dialog_utils.dart';
import 'package:tasksmanager/firebase_utils.dart';
import 'package:tasksmanager/model/userModel.dart';
import 'package:tasksmanager/provider/authProvider.dart';
import 'package:tasksmanager/widgets/auth/customTextFormField.dart';


class Register extends StatefulWidget {
  static String route_Name = "Register";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController userNameController =
      TextEditingController();

  TextEditingController emailController =
      TextEditingController();

  TextEditingController passwordController =
      TextEditingController();

  TextEditingController confirmPasswordController =
      TextEditingController();
  bool showPass = false;
  bool obscure = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

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
            "Create Account ",
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: height * 0.26,
                  ),
                  Customtextformfield(
                    isPassword: false,
                    controller: userNameController,
                    lableText: "User Name",
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please Enter User Name";
                      }
                      return null;
                    },
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
                  Customtextformfield(
                    isPassword: true,
                    isShown: showPass,
                    controller: confirmPasswordController,
                    lableText: "Confirm Password",
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
                      } else if (value != passwordController.text) {
                        return "Confirm Password Doesn't Equal Password";
                      }

                      return null;
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColor.primaryLightColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: MaterialButton(
                      onPressed: onRegister,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Register",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(Login.route_Name);
                    },
                    child: Text(
                      "Already Have Account?",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
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

  void onRegister() async {
    if (formKey.currentState!.validate() == true) {
      DialogUtils.showLoadingDialog(context, "Loading ...");
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        UserModel user = UserModel(
          id: credential.user?.uid ?? "",
          email: emailController.text,
          userName: userNameController.text,
        );
        var authProvider = Provider.of<Authprovider>(context, listen: false);
        authProvider.updateUser(user);
        
        FirebaseUtils.addUserToFirebase(user);
        DialogUtils.hideLoading(context);

        DialogUtils.showMessage(
          context: context,
          title: "Success",
          content: "Register Successfully",
          postActionNamed: "OK",
          posaction: () {
            Navigator.of(context).pushReplacementNamed(HomeScreen.route_Name);
          },
        );

        print("Register Successfully ${credential.user?.uid}");

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideLoading(context);

          DialogUtils.showMessage(
            context: context,
            content: "The password provided is too weak.",
          );
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            content: "The account already exists for that email.",
            postActionNamed: "Ok",
          );
          print('The account already exists for that email.');
        }
      } catch (e) {
        DialogUtils.hideLoading(context);

        DialogUtils.showMessage(
          context: context,
          content: e.toString(),
        );
        print(e);
      }
    }
  }
}
