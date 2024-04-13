import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/questions/questions_bloc.dart';
import '../../../core/global/global.dart';
import '../../../core/utilities/functions.dart';


class EditNameDialog extends StatefulWidget {

  const EditNameDialog({super.key});

  @override
  State<EditNameDialog> createState() => _EditNameDialogState();
}

class _EditNameDialogState extends State<EditNameDialog> {
  final _controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;

    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(size.height * 0.02),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('الإسم الجديد', style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: size.height * 0.02,),

              TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  labelText: 'الإسم',
                  hintText: name,
                  prefixIcon: const Icon(Icons.mail),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value == null || value.isEmpty ? 'برجاء إدخال الإسم' : null,
              ),
              SizedBox(height: size.height * 0.01),

              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                      child: SizedBox(
                          height: size.height * 0.07,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              elevation: 0,
                              backgroundColor: Theme.of(context).focusColor,
                              foregroundColor: Theme.of(context).primaryColor,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('cancel'),
                          )
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                      child: SizedBox(
                        height: size.height * 0.07,
                        child: ElevatedButton(
                          onPressed: (){
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<QuestionsBloc>(context)
                                  .add(EditNameEvent(newName: _controller.text));
                              Navigator.pop(context, _controller.text);
                              Helper.toast(context, 'تم تعديل الإسم');
                            }
                          },
                          child: const Text('تعديل'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}