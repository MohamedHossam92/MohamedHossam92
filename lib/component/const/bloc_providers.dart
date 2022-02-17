import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/angles/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/al_cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/wood_cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/windows/cubit/slide_cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/windows/cubit/turn_cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/z_other/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/utilities/todo/cubit/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/utilities/todo/cubit/db_cubit/cubit.dart';
import 'package:the_smart_workshop/sql/kitchen/cubit/cubit.dart';
import 'package:the_smart_workshop/sql/slide_windows/cubit/cubit.dart';
import 'package:the_smart_workshop/sql/turn_windows/cubit/cubit.dart';

List myBlocProviders = [
  BlocProvider(create: (context) => ComponentCubit()..getId()),
  BlocProvider(create: (context) => SlideCubit()),
  BlocProvider(create: (context) => TurnCubit()),
  BlocProvider(create: (context) => NoteCubit()),
  BlocProvider(create: (context) => AddNoteCubit()..createDb()),
  BlocProvider(create: (context) => HomeCubit()..initState(context)),
  BlocProvider(create: (context) => AddKitchenCubit()),
  BlocProvider(create: (context) => KitchenCubit()),
  BlocProvider(create: (context) => WoodCubit()),
  BlocProvider(create: (context) => CornerCubit()),
  BlocProvider(create: (context) => SQLSlideCubit()),
  BlocProvider(create: (context) => SQLTurnCubit()),
  BlocProvider(create: (context) => OtherDeductCubit()),
  BlocProvider(create: (context) => KitchenSettingCubit()..getAllPrefs()),
];
