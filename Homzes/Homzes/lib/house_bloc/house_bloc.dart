import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'house_state.dart';
import 'house_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HouseBloc extends Bloc<HouseEvent, HouseState> {
  HouseBloc() : super(HouseLoading()) {
    on<FetchHouses>(_onFetchHouses);
  }

  Future<void> _onFetchHouses(FetchHouses event, Emitter<HouseState> emit) async {
    try {
      emit(HouseLoading());
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Houses').get();
      List<Map<String, dynamic>> houses = querySnapshot.docs.map((doc) {
        return {
          'image': doc['Image'],
          'title': doc['Title'],
          'price': doc['Price'],
          'location': doc['Location'],
          'NumberOfBeds': doc['NumberofBeds'],
          'NumberOfBathrooms': doc['NumberOfBathrooms'],
        };
      }).toList();
      emit(HouseLoaded(houses));
    } catch (e) {
      emit(HouseError(e.toString()));
    }
  }
}
