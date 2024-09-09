import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvapp/features/app/domain/entities/category_entity.dart';
import 'package:tvapp/features/app/presentation/screen/home/cubit/home_cubit.dart';
import 'package:tvapp/features/app/presentation/screen/home/home_screen.dart';
import 'package:tvapp/features/app/presentation/screen/video_player/cubit/video_player_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        ///////////////////////// repository
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => VideoPlayerCubit(
            categoryList.first.channelList.first,
          ),
        )
      ],
      child: MaterialApp(
        title: "Photo Ai Luna",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: const HomeScreen(),
      ),
    );
  }
}
