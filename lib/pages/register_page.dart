import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sciencenotes/assets/colors/custom_colors.dart';
import 'package:sciencenotes/pages/enter_page.dart';
import 'package:sciencenotes/data/user_dao.dart';
import 'package:sciencenotes/domain/users.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController userController = TextEditingController(); 
  TextEditingController nameController = TextEditingController();
  TextEditingController nascimentController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: CustomColors.appeButtonColor,
        title: const Text(
          'Science Notes',
          style: TextStyle(fontSize: 24, color: CustomColors.white, fontFamily: 'Staatliches'),
        ),
      ),
      backgroundColor: CustomColors.gradienColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image.asset('lib/assets/images/logo.png', height: 300,),
                      const SizedBox(height: 24),
                      const Text(
                        "Criar conta",
                        style: TextStyle(
                          fontSize: 36,
                          color: CustomColors.textColor,
                          fontFamily: 'Staatliches',
                        ),
                      ),
                      const SizedBox(height: 36),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person_pin_rounded, color: CustomColors.appeButtonColor),
                          labelText: 'User',
                          labelStyle: TextStyle(
                            color: CustomColors.textColor,
                            fontFamily: 'Abel-Regular',
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: CustomColors.appeButtonColor,
                            ),
                          ),
                        ),
                        controller: userController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo usuário obrigatório';
                          } 
                            return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person, color: CustomColors.appeButtonColor),
                          labelText: 'Nome completo',
                          labelStyle: TextStyle(
                            color: CustomColors.textColor,
                            fontFamily: 'Abel-Regular',
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: CustomColors.appeButtonColor,
                            ),
                          ),
                        ),
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo nome completo obrigatório';
                          } 
                            return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(CupertinoIcons.calendar, color: CustomColors.appeButtonColor),
                          labelText: 'Data de nascimento',
                          labelStyle: TextStyle(
                            color: CustomColors.textColor,
                            fontFamily: 'Abel-Regular',
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: CustomColors.appeButtonColor,
                            ),
                          ),
                        ),
                        controller: nascimentController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo data de nascimento obrigatório';
                          } 
                            return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(CupertinoIcons.envelope_fill, color: CustomColors.appeButtonColor),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: CustomColors.textColor,
                            fontFamily: 'Abel-Regular',
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: CustomColors.appeButtonColor,
                            ),
                          ),
                        ),
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo email obrigatório';
                          } 
                            return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          icon: Icon(CupertinoIcons.lock_shield_fill, color: CustomColors.appeButtonColor),
                          labelText: 'Senha',
                          labelStyle: TextStyle(
                              color: CustomColors.textColor,
                              fontFamily: 'Abel-Regular',
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: CustomColors.appeButtonColor,
                              ),
                            ),
                          ),
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo senha obrigatório';
                            } 
                              return null;
                          },
                      ),
                      const SizedBox(height: 72),
                      ElevatedButton(
                        onPressed: onPressedButton,
                        style: ElevatedButton.styleFrom(
                          primary: CustomColors.appeButtonColor,
                          minimumSize: (const Size(170, 40)),
                        ),
                        child: const Text(
                          'Cadastrar',
                          style: TextStyle(
                            fontSize: 28,
                            color: CustomColors.white,
                            fontFamily: 'AmaticSC-Regular',
                          ),
                        ),
                      ),
                    ],
                  ),
              )
            ]
          ),
        ),
      ),
    );
  }
  void onPressedButton() async{
    if (_formKey.currentState!.validate()) {
      String user = userController.text;
      String password = passwordController.text;
      String email = emailController.text;
      String data = nascimentController.text;
      String name = nameController.text;

      // int id = 2;
      // bool antigoID = await UserDao().antigoID(id: id);
      // while(antigoID){
      //   id++;
      //   antigoID = await UserDao().antigoID(id: id);
      // }
      
       int id = await UserDao().listIDs();
       id++;

      Users newUser = Users(id: id, email: email, name: name, image: " ", password: password, username: user, birthdate: data);
      bool exclusivityUser = await UserDao().exclusivityUser(username: user);
      bool exclusivityEmail = await UserDao().exclusivityEmail(email: email);
      if(exclusivityUser){
        showSnackBar("Nome de usuário já cadastrado.");
      }else if (exclusivityEmail){
        showSnackBar("Email de usuário já cadastrado.");
      }else{
        await UserDao().saveUser(user: newUser);
        showSnackBar('Usuário foi salvo com sucesso!');
        Navigator.pop(context);
      }
    } else {
      showSnackBar("Erro na validação");
    }
  }

  showSnackBar(String msg) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(
        vertical: 80,
        horizontal: 32,
      ),
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // gerarID() async{
  //   int id = 2;
  //   bool antigoID = await UserDao().antigoID(id: id);
  //   while(antigoID){
  //     id++;
  //     antigoID = await UserDao().antigoID(id: id);
  //   }
  //   return id;
  // }
}