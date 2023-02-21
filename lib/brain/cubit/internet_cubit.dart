import 'package:bloc/bloc.dart';
import 'package:bloc_practice/constants/enum.dart';
import 'package:equatable/equatable.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  InternetCubit() : super(InternetLoading());
}
