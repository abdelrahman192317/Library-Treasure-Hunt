import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/ads_bloc/ads_bloc.dart';
import '../../bloc/connection/connection_bloc.dart';
import '../../bloc/questions/questions_bloc.dart';
import '../../bloc/values/values_bloc.dart';
import '../../core/global/global.dart';
import '../../core/utils/functions.dart';
import 'home.dart';


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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      width: size.width,
                      height: size.height * 0.4,
                      child: Image.asset('assets/images/welcome.png'
                      ),
                    ),
                  ),

                  Text('برجاء إدخال اسم المستخدم',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge,),
                  SizedBox(height: size.height * 0.01),

                  SizedBox(
                    height: size.height * 0.08,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              labelText: 'الاسم',
                              labelStyle: Theme.of(context).textTheme.titleMedium,
                            ),
                            enabled: editable,
                            keyboardType: TextInputType.name,
                            validator: (value) =>
                            value == null || value.isEmpty
                                ? 'برجاء ادخال الإسم'
                                : null,
                          ),
                        ),
                        if(name != null)
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              onPressed: () =>
                                  setState(() {
                                    editable = true;
                                  }),
                              icon: const Icon(Icons.edit, color: Colors.white),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),

                  SizedBox(
                    width: size.width,
                    height: size.height * 0.07,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<ValuesBloc>(context)
                              .add(
                              EditNameEvent(newName: _nameController.text));
                          Helper.toast(
                              context, 'مرحبا ${_nameController.text}');
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => BlocProvider(
                                create: (context) => ConnectionBloc()..add(InitialConnectionEvent()),
                                child: BlocProvider<AdsBloc>.value(
                                    value: adsBloc,
                                    child: BlocProvider<ValuesBloc>.value(
                                      value: valuesBloc,
                                      child: BlocProvider<QuestionsBloc>.value(
                                        value: questionsBloc,
                                        child: const Home(),
                                      ),
                              )))));
                        }
                      },
                      child: Text('ابدأ اللعب', style: Theme.of(context).textTheme.titleLarge,),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
