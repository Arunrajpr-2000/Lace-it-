part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class Searchproduct extends SearchEvent {
  Searchproduct({required this.search_input});
  String search_input;
}
