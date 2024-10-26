import 'package:flutter_bloc/flutter_bloc.dart';

class TabsLibraryCubit extends Cubit<int> {
  TabsLibraryCubit() : super(0);

  void myTabsLibraryController(int tabsChaged) => emit(tabsChaged);
}
