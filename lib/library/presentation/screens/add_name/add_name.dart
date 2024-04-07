import 'package:flutter/material.dart';

import '../../../core/utilities/colors.dart';
import '../home/home.dart';


class AddName extends StatefulWidget {
  const AddName({super.key});

  @override
  State<AddName> createState() => _AddNameState();
}

class _AddNameState extends State<AddName> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                background, canvas
              ]
            )
          ),
          padding: EdgeInsets.all(size.height * 0.03),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Hero(
                    tag: 'splash',
                    child: SizedBox(
                      width: size.width * 0.8,
                      height: size.height * 0.3,
                      child: Image.asset('assets/images/logo.png',),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),

                Text('برجاء إدخال إسم المستخدم',
                style: Theme.of(context).textTheme.titleMedium,),
                SizedBox(height: size.height * 0.02),

                SizedBox(
                  height: size.height * 0.07,
                  child: TextFormField(
                    onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(15))),
                      labelText: 'الإسم',
                      labelStyle: Theme.of(context).textTheme.bodySmall,
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) => value == null || value.isEmpty
                        ? 'برجاء ادخال الإسم'
                        : null,
                  ),
                ),
                SizedBox(height: size.height * 0.03),

                SizedBox(
                  width: size.width,
                  height: size.height * 0.07,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => const Home(),
                    )),
                    child: const Text('ابدأ اللعب'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
