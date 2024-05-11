import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../bloc/questions/questions_bloc.dart';
import '../../core/global/global.dart';
import '../../core/utilities/colors.dart';
import '../../data/models/questions_model.dart';


class EditQuestion extends StatefulWidget {
  final int difficulty, level, question;
  final Question q;
  const EditQuestion(
      {super.key,
        required this.difficulty,
        required this.level,
        required this.question,
        required this.q});

  @override
  State<EditQuestion> createState() => _EditQuestionState();
}

class _EditQuestionState extends State<EditQuestion> {
  final _formKey = GlobalKey<FormState>();

  String? _errorMessage;

  late TextEditingController _questionController;

  late TextEditingController _answer_1Controller;
  late TextEditingController _answer_2Controller;
  late TextEditingController _answer_3Controller;
  late TextEditingController _answer_4Controller;

  String _rightAnswer = '';

  bool _editable = false;

  bool _updating = false;

  @override
  void initState() {
    _questionController = TextEditingController(text: widget.q.question);
    
    _answer_1Controller = TextEditingController(text: widget.q.answer_1);
    _answer_2Controller = TextEditingController(text: widget.q.answer_2);
    _answer_3Controller = TextEditingController(text: widget.q.answer_3);
    _answer_4Controller = TextEditingController(text: widget.q.answer_4);
    
    _rightAnswer = widget.q.rightAnswer;
    super.initState();
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answer_1Controller.dispose();
    _answer_2Controller.dispose();
    _answer_3Controller.dispose();
    _answer_4Controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(size.height * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).shadowColor,
                    ),
                  ),
                  if(!_editable)TextButton(
                    onPressed: () => setState(() => _editable = true),
                    child: Text('Edit Question', style: TextStyle(color: primary),),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(size.height * 0.01),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.02),

                      //question
                      TextFormField(
                        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                        controller: _questionController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          labelText: 'Question',
                          labelStyle: Theme.of(context).textTheme.bodySmall,
                          prefixIcon: Icon(
                            Icons.question_mark,
                            color: Theme.of(context).primaryColor,
                          ),
                          enabled: _editable
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter question'
                            : null,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      //answer 1
                      Row(
                        children: [
                          if(_editable)Expanded(
                              flex: 1,
                              child: Radio(
                                value: _answer_1Controller.text,
                                groupValue: _rightAnswer,
                                onChanged: (value){
                                  setState(() {
                                    _rightAnswer = value!;
                                  });
                                },
                              )
                          ),
                          Expanded(
                            flex: 5,
                            child: TextFormField(
                              onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                              controller: _answer_1Controller,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                labelText: 'Answer 1',
                                labelStyle: Theme.of(context).textTheme.bodySmall,
                                prefixIcon: Icon(
                                  Icons.question_answer,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              keyboardType: TextInputType.name,
                              validator: (value) => value == null || value.isEmpty
                                  ? 'Please enter Answer 1'
                                  : null,
                              enabled: _editable,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),

                      //answer 2
                      Row(
                        children: [
                          if(_editable)Expanded(
                              flex: 1,
                              child: Radio(
                                value: _answer_2Controller.text,
                                groupValue: _rightAnswer,
                                onChanged: (value){
                                  setState(() {
                                    _rightAnswer = value!;
                                  });
                                },
                              )
                          ),
                          Expanded(
                            flex: 5,
                            child: TextFormField(
                              onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                              controller: _answer_2Controller,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                labelText: 'Answer 2',
                                labelStyle: Theme.of(context).textTheme.bodySmall,
                                prefixIcon: Icon(
                                  Icons.question_answer,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              keyboardType: TextInputType.name,
                              validator: (value) => value == null || value.isEmpty
                                  ? 'Please enter Answer 2'
                                  : null,
                              enabled: _editable,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),

                      //answer 3
                      Row(
                        children: [
                          if(_editable)Expanded(
                              flex: 1,
                              child: Radio(
                                value: _answer_3Controller.text,
                                groupValue: _rightAnswer,
                                onChanged: (value){
                                  setState(() {
                                    _rightAnswer = value!;
                                  });
                                },
                              )
                          ),
                          Expanded(
                            flex: 5,
                            child: TextFormField(
                              onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                              controller: _answer_3Controller,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                labelText: 'Answer 3',
                                labelStyle: Theme.of(context).textTheme.bodySmall,
                                prefixIcon: Icon(
                                  Icons.question_answer,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              keyboardType: TextInputType.name,
                              validator: (value) => value == null || value.isEmpty
                                  ? 'Please enter Answer 3'
                                  : null,
                              enabled: _editable,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),

                      //answer 4
                      Row(
                        children: [
                          if(_editable)Expanded(
                              flex: 1,
                              child: Radio(
                                value: _answer_4Controller.text,
                                groupValue: _rightAnswer,
                                onChanged: (value){
                                  setState(() {
                                    _rightAnswer = value!;
                                  });
                                },
                              )
                          ),
                          Expanded(
                            flex: 5,
                            child: TextFormField(
                              onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                              controller: _answer_4Controller,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                labelText: 'Answer 4',
                                labelStyle: Theme.of(context).textTheme.bodySmall,
                                prefixIcon: Icon(
                                  Icons.question_answer,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              keyboardType: TextInputType.name,
                              validator: (value) => value == null || value.isEmpty
                                  ? 'Please enter Answer 4'
                                  : null,
                              enabled: _editable,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),


                      if (_editable && _errorMessage != null) Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                      SizedBox(height: size.height * 0.04),

                      //add or cancel
                      if(_editable)Row(
                        children: [
                          //cancel
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02),
                              child: SizedBox(
                                  height: size.height * 0.08,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      elevation: 0,
                                      backgroundColor: Theme.of(context).focusColor,
                                      foregroundColor: Theme.of(context).primaryColor,
                                    ),
                                    onPressed: () {
                                      setState(() => _editable = false);
                                    },
                                    child: const Text('Cancel'),
                                  )),
                            ),
                          ),

                          //add
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02),
                              child: SizedBox(
                                height: size.height * 0.08,
                                child: ElevatedButton(
                                  onPressed: _updating
                                      ? null
                                      : () async {
                                    if (!_formKey.currentState!
                                        .validate()
                                    ) {
                                      setState(() {
                                        _errorMessage =
                                        'please add data first';
                                      });
                                    }else {
                                      // Set `_uploading` to true before starting the upload
                                      setState(() => _updating = true);
                                      await updateQuestion(context);
                                      setState(() => _updating = false);
                                    }
                                  },
                                  child: Text(
                                    _updating ? 'Adding...' : 'Add',
                                    style:
                                    const TextStyle(color: Colors.white),
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }

  Future updateQuestion(BuildContext context) async {

    try {

      CollectionReference questionCollection =
      FirebaseFirestore.instance.collection(difficulty[widget.difficulty]);

      //add question
      await questionCollection
          .doc('level ${widget.level}')
          .collection('Questions')
          .doc('${widget.question}')
          .update(Question.toMap(Question(
          question: _questionController.text,
          answer_1: _answer_1Controller.text,
          answer_2: _answer_2Controller.text,
          answer_3: _answer_3Controller.text,
          answer_4: _answer_4Controller.text,
          rightAnswer: _rightAnswer
      )));

      questionsBloc.add(FetchAllQuestionsEvent());

      Future.delayed(const Duration(seconds: 5));

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Question updated successfully'), duration: Duration(microseconds: 200),),
        );
      }
      _reset();
    } catch (e) {
      _errorMessage = 'Error: $e';
    }
  }

  void _reset() {
    setState(() => _editable = false);
    _errorMessage = null;

  }
}