import 'package:library_treasure_hunt/library/bloc/questions/questions_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/questions_model.dart';

SharedPreferences? sharedPreferences;

QuestionsBloc questionsBloc = QuestionsBloc();

List<Question> myQuestions = [];