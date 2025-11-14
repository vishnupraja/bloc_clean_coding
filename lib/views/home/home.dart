import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_coding/bloc/movies/movies_bloc.dart';
import 'package:flutter_clean_coding/config/components/loading_widget.dart';
import 'package:flutter_clean_coding/services/storage/local_storage.dart';
import 'package:flutter_clean_coding/utils/enums.dart';

import '../../config/color/colors.dart';
import '../../config/components/Internet_exception_widget.dart';
import '../../config/routes/route_name.dart';
import '../../dependency_injector/locator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void getData(BuildContext context){
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        context.read<MoviesBloc>().add(MoviesFetchLoadMore());
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('Home'),
        actions: [
          IconButton(onPressed: (){
            LocalStorage local = LocalStorage();
            local.clearValue("token").then((value){
             local.clearValue("isLogin").then((value){
               Navigator.pushNamedAndRemoveUntil(context, RouteName.loginScreen, (route) => false);
             });
            });

          }, icon: const Icon(Icons.login))
        ],
      ),
      body: BlocProvider(
          create:(context) => MoviesBloc(moviesRepository: getIt())..add(MoviesFetch()),
              child: Builder(
                builder: (context) {
                  getData(context);
                  return BlocBuilder<MoviesBloc,MoviesStates>(
                  builder: (BuildContext context, state) {
                    switch(state.moviesList.status){
                      case Status.loading:
                        return const Center(child: LoadingWidget(color: AppColors.primary,size: 40,));
                        case Status.completed:
                          if((state.moviesList.data?.tvShows ?? []).isEmpty){
                            return const Center(child: Text("Not data found"),);
                          }

                          return ListView.builder(
                            controller: _scrollController,
                            itemCount: (state.moviesList.data?.tvShows ?? []).length + (state.isLoadingMore ? 1 :0),
                            itemBuilder: (context, index) {
                              if (index == (state.moviesList.data?.tvShows ?? []).length) {
                                return const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Center(
                                      child: LoadingWidget(color: AppColors.primary,size: 40,)),
                                );
                              }
                              final data = (state.moviesList.data?.tvShows ?? [])[index];
                              return Card(
                                child: ListTile(
                                  title: Text(data.name),
                                  subtitle: Text(data.network),
                                  trailing: Text(data.status),
                                ),
                              );
                            },
                          );
                      case Status.error:
                        if(state.moviesList.message == "No Internet Connection"){
                          return InternetExceptionWidget(
                            callback: () {
                              BlocProvider.of<MoviesBloc>(context).add(MoviesFetch());
                            },
                          );
                        }
                        return Center(child: Text(state.moviesList.message.toString()),);
                      default:
                        return const SizedBox();
                    }
                  },);
                }
              ),
      ),
    );
  }
}
