import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smpark/src/cubit/detail_cubit.dart';
import 'package:smpark/src/providers/list_provider.dart';
import 'package:smpark/src/utils/map_utils.dart';

class DetailPage extends StatelessWidget {
  final ObjectPark _park;
  const DetailPage(this._park, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailCubit(),
      child: LayoutBuilder(builder: (context, snapshot) {
        return BlocListener<DetailCubit, DetailState>(
          listener: (context, state) {
            if (state is LocationLoadedState) {
              if (state.lat != null && state.long != null)
                MapUtils.openMap(
                    state.lat!, state.long!, _park.latitude, _park.longitude);
              else
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text("Al parecer no pudimos conseguir tu ubicación")));
            }
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomScrollView(
                slivers: [
                  SliverSafeArea(
                    sliver: SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: AspectRatio(
                          aspectRatio: 3 / 1,
                          child: Stack(
                            alignment: Alignment.centerRight,
                            clipBehavior: Clip.antiAlias,
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                clipBehavior: Clip.antiAlias,
                                child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(_park.streeImage)),
                              ),
                              Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Text(_park.streetName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          ?.copyWith(
                                              color: Colors.blueGrey[200]))),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 24, width: 0),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Colors.blueGrey[800],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: Text(
                                    "Información",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20, width: 0),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.blueGrey[800],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        fit: StackFit.loose,
                                        clipBehavior: Clip.antiAlias,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Tarifa"),
                                          ),
                                          Positioned(
                                              width: 200,
                                              height: 1,
                                              bottom: 1,
                                              right: 0,
                                              child: Container(
                                                  color: Colors.white)),
                                          Positioned(
                                              height: 30,
                                              width: 1,
                                              right: 0,
                                              bottom: 1,
                                              child: Container(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        fit: StackFit.loose,
                                        clipBehavior: Clip.antiAlias,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Horario"),
                                          ),
                                          Positioned(
                                              width: 200,
                                              height: 1,
                                              bottom: 1,
                                              left: 0,
                                              child: Container(
                                                  color: Colors.white)),
                                          Positioned(
                                              height: 30,
                                              width: 1,
                                              left: 0,
                                              bottom: 1,
                                              child: Container(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 60,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              fit: StackFit.loose,
                                              clipBehavior: Clip.antiAlias,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Text("S/ 5 por hora"),
                                                ),
                                                Positioned(
                                                    width: 200,
                                                    height: 1,
                                                    bottom: 1,
                                                    right: 0,
                                                    child: Container(
                                                        color: Colors.white)),
                                                Positioned(
                                                    height: 100,
                                                    width: 1,
                                                    right: 0,
                                                    bottom: 1,
                                                    child: Container(
                                                        color: Colors.white)),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 60,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              fit: StackFit.loose,
                                              clipBehavior: Clip.antiAlias,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "Lavado de autos\nS/ 6 soles",
                                                      textAlign:
                                                          TextAlign.center),
                                                ),
                                                Positioned(
                                                    width: 200,
                                                    height: 1,
                                                    bottom: 1,
                                                    right: 0,
                                                    child: Container(
                                                        color: Colors.white)),
                                                Positioned(
                                                    height: 100,
                                                    width: 1,
                                                    right: 0,
                                                    bottom: 1,
                                                    child: Container(
                                                        color: Colors.white)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 60,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              fit: StackFit.loose,
                                              clipBehavior: Clip.antiAlias,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "L - V\n10:00 a.m. - 10:00 p.m.",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Positioned(
                                                    height: 100,
                                                    width: 1,
                                                    left: 0,
                                                    bottom: 1,
                                                    child: Container(
                                                        color: Colors.white)),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 60,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              fit: StackFit.loose,
                                              clipBehavior: Clip.antiAlias,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "S - D\n9:00 a.m. - 11:30 p.m.",
                                                      textAlign:
                                                          TextAlign.center),
                                                ),
                                                Positioned(
                                                    height: 100,
                                                    width: 1,
                                                    left: 0,
                                                    bottom: 1,
                                                    child: Container(
                                                        color: Colors.white)),
                                                Positioned(
                                                    width: 200,
                                                    height: 1,
                                                    bottom: 1,
                                                    left: 0,
                                                    child: Container(
                                                        color: Colors.white)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () => context
                                      .read<DetailCubit>()
                                      .fetchLocation(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 8),
                                    child: Text("¿Cómo llegar?"),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Column(
                            children: [
                              const SizedBox(height: 15, width: 0),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Colors.blueGrey[800],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: Text(
                                    "Puntos de interés",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20, width: 0),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2 / 1.5),
                            itemBuilder: (_, position) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  clipBehavior: Clip.antiAlias,
                                  child: Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(_park.poi[position])),
                                ),
                              );
                            },
                            itemCount: _park.poi.length,
                          ),
                        ),
                        Container(
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(20)),
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          width: 0,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
