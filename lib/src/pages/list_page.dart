import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smpark/src/cubit/list_cubit.dart';
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
    return BlocProvider(
      create: (context) => ListCubit()..fetchItems(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Column(
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
                        child: NotificationListener(
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
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.white)),
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
                                            image:
                                                NetworkImage(item.streeImage)),
                                      ),
                                      Positioned(
                                          bottom: 10,
                                          left: 10,
                                          child: Text(item.streetName,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  ?.copyWith(
                                                      color: Colors
                                                          .blueGrey[200]))),
                                      Positioned(
                                          width: 30,
                                          height: 30,
                                          right: 15,
                                          child:
                                              ValueListenableBuilder<List<int>>(
                                                  valueListenable:
                                                      _visibilityRange,
                                                  builder: (_, snapshot, __) =>
                                                      _ParkDotState(
                                                          item.streetStatus,
                                                          position,
                                                          snapshot)))
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: state.items.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 0, height: 10),
                          ),
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

  _resetDotAnimations() {}
}

class _ParkDotState extends StatefulWidget {
  final String _parkState;
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
    var dotColor = widget._parkState == "GREEN"
        ? Colors.green
        : widget._parkState == "YELLOW"
            ? Colors.yellow
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
