import 'package:flutter_bloc/flutter_bloc.dart';

class TabsBottomNavCubit extends Cubit<int> {
  TabsBottomNavCubit() : super(0);

  void myTabsController(int tabsBNChaged) => emit(tabsBNChaged);
}
