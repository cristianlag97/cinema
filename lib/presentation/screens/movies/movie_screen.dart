import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import '../../providers/providers.dart';

class MovieScreen extends ConsumerStatefulWidget {
  const MovieScreen({required this.movieId, super.key});

  final String movieId;

  static const name = 'movie-screen';

  @override
  ConsumerState<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfo.notifier).loadmovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movieDetail = ref.watch(movieInfo)[widget.movieId];

    if (movieDetail == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movieDetail),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _MovieDetails(movie: movieDetail),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  const _MovieDetails({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),
              const SizedBox(width: 10),

              //Descripcion

              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(movie.title, style: textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(movie.overview)
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds
                  .map(
                    (gender) => Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Chip(
                        label: Text(gender),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  )
                  .toList()
            ],
          ),
        ),
        _ActorsByMovie(movieId: movie.id.toString()),
        const SizedBox(height: 50)
      ],
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  const _CustomSliverAppBar({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        // title: Text(
        //   movie.title,
        //   style: const TextStyle(fontSize: 20),
        //   textAlign: TextAlign.start,
        // ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.7, 1.0],
                      colors: [Colors.transparent, Colors.black87]),
                ),
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    stops: [0.0, 0.3],
                    colors: [Colors.black87, Colors.transparent],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  const _ActorsByMovie({required this.movieId});

  final String movieId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorsBymovie = ref.watch(actorsByMovieProvider);

    if (actorsBymovie[movieId] == null) {
      return const CircularProgressIndicator(strokeWidth: 2);
    }

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actorsBymovie[movieId]!.length,
        itemBuilder: (BuildContext context, int index) {
          final actor = actorsBymovie[movieId]![index];
          return Container(
            padding: const EdgeInsets.all(8),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  actor.name,
                  maxLines: 1,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  actor.character,
                  maxLines: 2,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
