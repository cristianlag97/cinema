part of presentation.widget.movies;

class MoviePosterLink extends StatelessWidget {
  const MoviePosterLink({required this.movie, super.key});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: GestureDetector(
        onTap: () => context.push('/home/2/movie/${movie.id}'),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(movie.posterPath),
        ),
      ),
    );
  }
}
