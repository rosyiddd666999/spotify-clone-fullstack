import 'package:flutter_bloc/flutter_bloc.dart';

class TabsHomeCubit extends Cubit<int> {
  TabsHomeCubit() : super(0);

  void myTabsHomeController(int tabsChaged) => emit(tabsChaged);
}
