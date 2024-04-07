import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/models/questions_model.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({super.key});

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();

  String? _errorMessage;

  bool categoriesSelected = false;

  final _questionController = TextEditingController();
  final _answer_1Controller = TextEditingController();
  final _answer_2Controller = TextEditingController();
  final _answer_3Controller = TextEditingController();

  int _selectedLevel = 0;

  final List<String> _difficultyList = ['easy', 'middle', 'difficult'];
  String _selectedDifficulty = 'easy';


  bool _uploading = false;

  @override
  void dispose() {
    _questionController.dispose();
    _answer_1Controller.dispose();
    _answer_2Controller.dispose();
    _answer_3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(size.height * 0.01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.03),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).shadowColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(size.height * 0.01),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.02),

                        Text('Adding Restaurant',
                            style: Theme.of(context).textTheme.titleLarge),
                        SizedBox(height: size.height * 0.01),

                        const Text(
                          'please enter the required data',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        SizedBox(height: size.height * 0.05),

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
                        TextFormField(
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
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),

                        //answer 2
                        TextFormField(
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
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),

                        //answer 3
                        TextFormField(
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
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),


                        // level + difficulty
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: size.height * 0.08,
                                child: DropdownButton(
                                  value: _selectedLevel,
                                  items: List.generate(10, (index) => DropdownMenuItem(
                                        value: index,
                                        child: Text('Level $index')
                                      ),
                                  ),
                                  onChanged: (val){
                                    setState(() {
                                      _selectedLevel = val!;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: size.width * 0.01),
                            Expanded(
                              child: SizedBox(
                                height: size.height * 0.08,
                                child: DropdownButton(
                                  value: _selectedDifficulty,
                                  items: _difficultyList.map((i) => DropdownMenuItem(
                                    value: i,
                                    child: Text(i),
                                  )).toList(),
                                  onChanged: (val){
                                    setState(() {
                                      _selectedDifficulty = val!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),


                        if (_errorMessage != null) Text(
                            _errorMessage!,
                            style: const TextStyle(color: Colors.red),
                        ),
                        SizedBox(height: size.height * 0.04),

                        //add or cancel
                        Row(
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
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        elevation: 0,
                                        backgroundColor:
                                            Theme.of(context).focusColor,
                                        foregroundColor:
                                            Theme.of(context).primaryColor,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
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
                                    onPressed: _uploading
                                        ? null
                                        : () async {
                                            if (!_formKey.currentState!
                                                .validate()
                                            ) {
                                              setState(() {
                                                _errorMessage =
                                                    'please add data first';
                                              });
                                            } else {
                                              // Set `_uploading` to true before starting the upload
                                              setState(() {
                                                _uploading = true;
                                              });

                                              // Call the function to upload data
                                              await uploadQuestion(context);

                                              // Set `_uploading` to false after the upload is complete
                                              setState(() {
                                                _uploading = false;
                                              });
                                            }
                                          },
                                    child: Text(
                                      _uploading ? 'Adding...' : 'Add',
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
      ),
    );
  }

  Future uploadQuestion(BuildContext context) async {

    try {

      CollectionReference questionCollection =
          FirebaseFirestore.instance.collection('Questions');


      // Add the data to Firestore
      DocumentReference questionDocRef = await questionCollection.add(Question(
        level: _selectedLevel,
        difficulty: _selectedDifficulty,
        question: _questionController.text,
        answer_1: _answer_1Controller.text,
        answer_2: _answer_2Controller.text,
        answer_3: _answer_3Controller.text,
        rightAnswer: 0,
      ));

      await questionCollection.add(questionDocRef);


      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Questions added successfully'),
          ),
        );
      }
      _clearFields();
    } catch (e) {
      _errorMessage = 'Error: $e';
    }
  }

  void _clearFields() {
    _questionController.clear();
    _answer_1Controller.clear();
    _answer_2Controller.clear();
    _answer_3Controller.clear();

    _errorMessage = null;

  }
}
