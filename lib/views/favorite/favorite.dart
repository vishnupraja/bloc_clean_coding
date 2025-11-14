import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_coding/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:flutter_clean_coding/config/color/colors.dart';
import 'package:flutter_clean_coding/config/components/Internet_exception_widget.dart';
import 'package:flutter_clean_coding/config/components/loading_widget.dart';
import 'package:flutter_clean_coding/dependency_injector/locator.dart';
import 'package:flutter_clean_coding/main.dart';

import '../../utils/enums.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FavoriteBloc(favoriteRepository: getIt())..add(GetFavoriteData()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Favorite"),
              actions: [
                BlocBuilder<FavoriteBloc, FavoriteStates>(
                    builder: (context, state) {
                  return Visibility(
                    visible: state.tempList.isNotEmpty,
                    child: IconButton(
                      onPressed: () {
                        context.read<FavoriteBloc>().add(DeleteItem());
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  );
                })
              ],
            ),
            body: BlocBuilder<FavoriteBloc, FavoriteStates>(
              builder: (context, state) {
                switch (state.favoriteList.status) {
                  case Status.loading:
                    return const Center(
                        child: LoadingWidget(
                      color: AppColors.primary,
                      size: 40,
                    ));
                  case Status.completed:
                    return ListView.builder(
                      itemCount: state.favoriteList.data?.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(state.favoriteList.data![index].name),
                            trailing: IconButton(
                                onPressed: () {
                                  context.read<FavoriteBloc>().add(AddFavorite(
                                      id: state.favoriteList.data![index].id));
                                },
                                icon: state.favoriteList.data![index].favorite
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : const Icon(Icons.favorite_border)),
                            leading: Checkbox(
                                value: (state.tempList ?? []).any((e) =>
                                    e.id == state.favoriteList.data![index].id),
                                onChanged: (value) {
                                  if (value!) {
                                    context.read<FavoriteBloc>().add(SelectItem(
                                        id: state
                                            .favoriteList.data![index].id));
                                  } else {
                                    context.read<FavoriteBloc>().add(
                                        UnSelectItem(
                                            id: state
                                                .favoriteList.data![index].id));
                                  }
                                }),
                          ),
                        );
                      },
                    );
                  case Status.error:
                    if (state.favoriteList.message ==
                        "No Internet Connection") {
                      return InternetExceptionWidget(
                        callback: () {},
                      );
                    }
                    return Center(
                      child: Text(state.favoriteList.message.toString()),
                    );
                  default:
                    return const SizedBox();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
