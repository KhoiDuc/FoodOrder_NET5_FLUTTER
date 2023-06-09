import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Search/SearchEvent.dart';
import 'package:food_delivery/bloc/Search/SearchState.dart';
import 'package:food_delivery/services/FoodServices.dart';
import 'package:food_delivery/view_models/commons/PagingRequest.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchEmptyState());
  final FoodServices _foodServices = FoodServices();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchTextChangedEvent) {
      final String searchString = event.searchText;
      if (searchString.isEmpty) {
        yield SearchEmptyState();
        return;
      }
      yield SearchLoadingState();

      var result = await _foodServices.searchFood(PagingRequest(
          searchString: event.searchText, pageNumber: 1, sortOrder: null));
      if (result.isSuccessed) {
        yield SearchSuccessState(result.payLoad!.items!);
      } else {
        yield SearchErrorState(result.errorMessage!);
      }
    }
  }

  @override
  void onTransition(Transition<SearchEvent, SearchState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
      Stream<SearchEvent> events,
      Stream<Transition<SearchEvent, SearchState>> Function(SearchEvent event)
          transitionFn) {
    return events
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap(transitionFn);
  }
}
