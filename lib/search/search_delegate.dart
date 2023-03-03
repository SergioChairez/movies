import 'package:flutter/material.dart';

import 'package:movies/providers/movies_providers.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon( Icons.clear )
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon( Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildresults');
  }

  Widget _emptyContainer() {
    return Container(
      child: const Center(
        child: Icon( Icons.movie, color: Colors.black38, size: 130, ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if ( query.isEmpty ) {
      return _emptyContainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.searchMovies(query),
      builder: ( _, AsyncSnapshot<List<Movie>> snapshot ){

        if ( !snapshot.hasData ) return _emptyContainer();

        final movies = snapshot.data!;

        return ListView.builder(
          itemCount: movies.length,
            itemBuilder: ( _, int index ) => _MovieItem(movie: movies[index])
        );
      },

    );

  }

}

class _MovieItem extends StatelessWidget {

  final Movie movie;

  const _MovieItem({
    Key? key,
    required this.movie
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
        placeholder: const AssetImage('assets/no-image.jpg'),
        image: NetworkImage( movie.fullPosterImg ),
        width: 50,
        fit: BoxFit.cover,
      ),
      title:  Text( movie.title ),
      subtitle: Text( movie.originalTitle ),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}
