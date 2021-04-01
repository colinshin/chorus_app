import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {
  final Function handleSearch;
  final Function handleDelete;
  final String recent;
  final Function handleClose;

  SearchItem(
      {@required this.handleSearch,
      @required this.handleClose,
      @required this.handleDelete,
      @required this.recent});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      decoration: BoxDecoration(
          color: Colors.white38, borderRadius: BorderRadius.circular(10.3)),
      child: ListTile(
        leading: IconButton(
          icon: Icon(Icons.restore),
          onPressed: () => handleSearch(recent),
        ),
        trailing: IconButton(
          onPressed: () => handleDelete(recent),
          icon: AnimatedIcon(
            icon: AnimatedIcons.close_menu,
            progress: CurvedAnimation(
                curve: Curves.easeInToLinear,
                parent: AnimationController(
                    duration: Duration(milliseconds: 200),
                    vsync: Scaffold.of(context))),
            color: Theme.of(context).primaryColor,
          ),
        ),
        title: GestureDetector(
          child: Text(
            "$recent",
            maxLines: 1,
            style:
                Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 20.0),
          ),
          onTap: () => handleSearch(recent),
        ),
        onTap: () => handleClose(context, recent),
      ),
    );
  }
}

Widget deleteAllSearched(
    {@required BuildContext ctx, Function handleDeleteAll}) {
  return Container(
    padding: EdgeInsets.only(left: 20, right: 6),
    margin: EdgeInsets.symmetric(vertical: 3.0),
    decoration: BoxDecoration(
        color: Colors.white38, borderRadius: BorderRadius.circular(10.3)),
    child: ListTile(
      onTap: handleDeleteAll,
      trailing: AnimatedIcon(
        icon: AnimatedIcons.close_menu,
        progress: CurvedAnimation(
            curve: Curves.elasticIn,
            parent: AnimationController(
                duration: Duration(milliseconds: 200),
                vsync: Scaffold.of(ctx))),
        color: Theme.of(ctx).primaryColor,
      ),
      title: Center(
        child: Text(
          "Eliminar todos recientes",
          maxLines: 1,
          style: Theme.of(ctx).textTheme.headline1.copyWith(fontSize: 22.0),
        ),
      ),
    ),
  );
}
