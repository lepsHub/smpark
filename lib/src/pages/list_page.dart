import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:smpark/api/service/service_service.dart';
import 'package:smpark/api/service_api.dart';
import 'package:smpark/src/cubit/list_cubit.dart';
import 'package:smpark/src/pages/detail_page.dart';
import 'package:smpark/src/providers/list_provider.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<List<int>> _visibilityRange = ValueNotifier([0, 1]);

  @override
  void dispose() {
    _scrollController.dispose();
    _visibilityRange.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget addressAutoCompleteWidget = SizedBox(width: 0, height: 0);
    Widget ListWidget = Center(child: CircularProgressIndicator());

    return BlocProvider(
      create: (context) =>
          ListCubit(ServiceServiceImpl(ServiceAPI()), new Location())
            ..fetchItems(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Builder(builder: (context) {
              return Column(
                children: [
                  Row(
                    children: [
                      Icon(CupertinoIcons.location_solid, size: 30),
                      Expanded(
                        child: TextField(
                          onChanged: (val) {
                            if (val.length > 4)
                              context.read<ListCubit>().searchAddress(val);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Buscar dirección',
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 0, height: 10),
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: BlocBuilder<ListCubit, ListState>(
                            builder: (context, state) {
                              if (state is AddressesLoadedState)
                                addressAutoCompleteWidget = ListView.builder(
                                  itemBuilder: (_, position) {
                                    return ListTile(
                                      title: Text(state
                                          .items[position].formattedAddress),
                                      onTap: () => context
                                          .read<ListCubit>()
                                          .fetchItems(),
                                    );
                                  },
                                  itemCount: state.items.length,
                                );
                              else if (state is ListLoadedState)
                                addressAutoCompleteWidget =
                                    SizedBox(width: 0, height: 0);
                              return addressAutoCompleteWidget;
                            },
                          ),
                        ),
                        BlocBuilder<ListCubit, ListState>(
                          builder: (context, state) {
                            if (state is ListErrorState)
                              return Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Ocurrio un error"),
                                    const SizedBox(height: 6, width: 0),
                                    Text(
                                      "Revisa que tu GPS este activo y brindanos permisos",
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 6, width: 0),
                                    ElevatedButton(
                                      onPressed: () => context
                                          .read<ListCubit>()
                                          .fetchItems(),
                                      child: Text("Reintentar"),
                                    ),
                                  ],
                                ),
                              );
                            if (state is ListLoadingState)
                              ListWidget =
                                  Center(child: CircularProgressIndicator());
                            else if (state is ListEmptyState) {
                              ListWidget = Center(
                                  child: Column(
                                children: [
                                  Text('No hay estacionamientos'),
                                  ElevatedButton(
                                    onPressed: () =>
                                        context.read<ListCubit>().fetchItems(),
                                    child: Text("Reintentar"),
                                  ),
                                ],
                              ));
                            } else if (state is ListLoadedState) {
                              ListWidget = NotificationListener(
                                onNotification: (not) {
                                  if (not is ScrollEndNotification)
                                    _resetDotAnimations();
                                  return true;
                                },
                                child: ListView.separated(
                                  controller: _scrollController,
                                  itemBuilder: (_, position) {
                                    ObjectPark item = state.items[position];
                                    return AspectRatio(
                                      aspectRatio: 3 / 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.white)),
                                        child: InkWell(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      DetailPage(item))),
                                          child: Stack(
                                            alignment: Alignment.centerRight,
                                            clipBehavior: Clip.antiAlias,
                                            fit: StackFit.expand,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                clipBehavior: Clip.antiAlias,
                                                child: Image(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(item
                                                            .foto ??
                                                        "https://picsum.photos/500/300/?Image=101")),
                                              ),
                                              Positioned(
                                                  bottom: 10,
                                                  left: 10,
                                                  child: Text(item.nombre,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          ?.copyWith(
                                                              color: Colors
                                                                      .blueGrey[
                                                                  200]))),
                                              Positioned(
                                                  width: 30,
                                                  height: 30,
                                                  right: 15,
                                                  child: ValueListenableBuilder<
                                                          List<int>>(
                                                      valueListenable:
                                                          _visibilityRange,
                                                      builder: (_, snapshot, __) =>
                                                          _ParkDotState(
                                                              _calculateStatus(
                                                                  item.estado!
                                                                          .total ??
                                                                      0,
                                                                  item.estado!
                                                                          .libres ??
                                                                      0),
                                                              position,
                                                              snapshot)))
                                            ],
                                          ),
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
                            return ListWidget;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  _resetDotAnimations() {}

  StatusState _calculateStatus(int total, int free) {
    if (total - free == 0)
      return StatusState.FULL;
    else if (free >= total * .66)
      return StatusState.FREE;
    else if (free >= total * .33)
      return StatusState.PARTIAL;
    else
      return StatusState.ALMOST;
  }
}

class _ParkDotState extends StatefulWidget {
  final StatusState _parkState;
  final int _position;
  final List<int> _range;
  _ParkDotState(this._parkState, this._position, this._range, {Key? key})
      : super(key: key);

  @override
  __ParkDotStateState createState() => __ParkDotStateState();
}

class __ParkDotStateState extends State<_ParkDotState>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 800),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  Widget build(BuildContext context) {
    var dotColor = widget._parkState == StatusState.FREE
        ? Colors.green
        : widget._parkState == StatusState.PARTIAL
            ? Colors.yellow
            : widget._parkState == StatusState.ALMOST
                ? Colors.orange
                : Colors.red;

    return Stack(alignment: Alignment.center, children: [
      Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: dotColor),
      ),
      ScaleTransition(
        scale: _animation,
        child: Opacity(
          opacity: .5,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: dotColor),
            width: 30,
            height: 30,
          ),
        ),
      ),
    ]);
  }
}

enum StatusState { FULL, ALMOST, PARTIAL, FREE }
