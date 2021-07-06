import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smpark/src/cubit/list_cubit.dart';
import 'package:smpark/src/providers/list_provider.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListCubit()..fetchItems(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment:,
              children: [
                Row(
                  children: [
                    Icon(CupertinoIcons.location_solid),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Buscar dirección',
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(width: 0, height: 10),
                BlocBuilder<ListCubit, ListState>(
                  builder: (context, state) {
                    if (state is ListLoadedState) {
                      return Expanded(
                        child: ListView.separated(
                          itemBuilder: (_, position) {
                            ObjectPark item = state.items[position];
                            return AspectRatio(
                              aspectRatio: 3 / 1,
                              child: Container(
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        clipBehavior: Clip.antiAlias,
                                        child: Image(
                                            image:
                                                NetworkImage(item.streeImage)))
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: state.items.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 0, height: 10),
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
