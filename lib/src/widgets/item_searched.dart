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
    return ListTile(
      leading: IconButton(
        icon: Icon(Icons.restore),
        onPressed: () => handleSearch(recent),
      ),
      trailing: IconButton(
        onPressed: () => handleDelete(recent),
        icon: Icon(Icons.delete),
        color: Colors.red,
      ),
      title: GestureDetector(
        child: Text(
          "$recent",
          maxLines: 1,
        ),
        onTap: () => handleSearch(recent),
      ),
      onTap: () => handleClose(context, recent),
    );
  }
}

Widget deleteAllSearched({Function handleDeleteAll}) {
  return Container(
    height: 60,
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: ListTile(
      onTap: handleDeleteAll,
      trailing: Icon(
        Icons.delete,
        color: Colors.red,
      ),
      title: Text(
        "Eliminar todas las busquedas",
        maxLines: 1,
      ),
    ),
  );
}
