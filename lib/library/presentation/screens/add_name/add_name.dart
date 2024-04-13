import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/questions/questions_bloc.dart';
import '../../../core/global/global.dart';
import '../../../core/utilities/functions.dart';
import '../home/home.dart';


class AddName extends StatefulWidget {
  const AddName({super.key});

  @override
  State<AddName> createState() => _AddNameState();
}

class _AddNameState extends State<AddName> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;

  late bool editable;

  @override
  void initState() {
    questionsBloc.add(GetNameEvent());
    _nameController = TextEditingController(text: name);
    editable = name == null? true : false;
    super.initState();
  }

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
        body: SingleChildScrollView(
          child: Padding(
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

                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 5,
                        child: SizedBox(
                          height: size.height * 0.08,
                          child: TextFormField(
                            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                            controller: _nameController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                              labelText: 'الإسم',
                              labelStyle: Theme.of(context).textTheme.bodySmall,
                            ),
                            enabled: editable,
                            keyboardType: TextInputType.name,
                            validator: (value) => value == null || value.isEmpty
                                ? 'برجاء ادخال الإسم'
                                : null,
                          ),
                        ),
                      ),
                      if(name != null)
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: size.height * 0.08,
                          child: IconButton(
                            onPressed: () => setState(() {
                              editable = true;
                            }),
                            icon: const Icon(Icons.edit),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.03),

                  SizedBox(
                    width: size.width,
                    height: size.height * 0.08,
                    child: ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          BlocProvider.of<QuestionsBloc>(context)
                              .add(EditNameEvent(newName: _nameController.text));
                          Helper.toast(context, 'تم تعديل الإسم');
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => const Home(),
                          ));
                        }
                      },
                      child: const Text('ابدأ اللعب'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
