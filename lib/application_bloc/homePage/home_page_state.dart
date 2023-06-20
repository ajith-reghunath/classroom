part of 'home_page_bloc.dart';

class HomePageState {
  final List<StudentModel> studentList;

  HomePageState({required this.studentList});

  factory HomePageState.initial() {
    return HomePageState(studentList: []);
  }
}
