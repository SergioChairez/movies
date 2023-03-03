import 'package:flutter/material.dart';

import 'package:movies/providers/movies_providers.dart';
import 'package:movies/search/search_delegate.dart';
import 'package:movies/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies in Theater'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),
              icon: const Icon( Icons.search_outlined )
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            // Main Cards
            CardSwiper(
                movies: moviesProvider.onDisplayMovies
            ),

            // Movie Slider
            MovieSlider(
              movies: moviesProvider.popularMovies,
              title: 'Popular',
              onNextPage: () => moviesProvider.getPopularMovies(),
            ),

          ],

        ),
      )
    );
  }
}
