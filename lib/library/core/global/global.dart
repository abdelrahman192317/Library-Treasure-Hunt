import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/ads_bloc/ads_bloc.dart';
import '../../bloc/questions/questions_bloc.dart';
import '../../bloc/values/values_bloc.dart';
import '../../data/models/questions_model.dart';

SharedPreferences? sharedPreferences;

String? name;
int? heartCount;

DateTime? lastCloseTime;

List<String> difficulty = ['easy', 'middle', 'hard'];

QuestionsBloc questionsBloc = QuestionsBloc();
ValuesBloc valuesBloc = ValuesBloc();
AdsBloc adsBloc = AdsBloc();

List<List<List<Question>>> myAllQuestions = [[],[],[]];
List<List<Map<String, String>>> myAllSolvedQuestions = [[],[],[]];

List<String> levels = [
  'الأول','الثاني','الثالث','الرابع','الخامس','السادس','السابع','الثامن','التاسع','العاشر'
];

final player = AudioPlayer();
