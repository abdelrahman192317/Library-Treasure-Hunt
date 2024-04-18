import 'package:library_treasure_hunt/library/bloc/questions/questions_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/values/values_bloc.dart';
import '../../data/models/questions_model.dart';

SharedPreferences? sharedPreferences;

String? name;
int? heartCount;

List<String> difficulty = ['easy', 'middle', 'hard'];

QuestionsBloc questionsBloc = QuestionsBloc();
ValuesBloc valuesBloc = ValuesBloc();

List<List<List<Question>>> myAllQuestions = [[],[],[]];
List<List<Map<String, String>>> myAllSolvedQuestions = [[],[],[]];

List<List<Question>> myEasyQuestions = [];
List<List<String>> myEasySolvedQuestions = [];

List<List<Question>> myMiddleQuestions = [];
List<List<String>> myMiddleSolvedQuestions = [];

List<List<Question>> myHardQuestions = [];
List<List<String>> myHardSolvedQuestions = [];

List<String> levels = [
  'الأول','الثاني','الثالث','الرابع','الخامس','السادس','السابع','الثامن','التاسع','العاشر'
];

