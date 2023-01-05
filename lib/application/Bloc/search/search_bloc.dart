import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lace_it/function/search_fun.dart';
import 'package:lace_it/model/product_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(InitialState()) {
    on<SearchEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<Searchproduct>((event, emit) async {
      List<Product> searchlist =
          await SearchFuction.searchProduct(search_input: event.search_input);
      emit(SearchState(productList: searchlist));
    });
  }
}
