//TODO: leer diferentes modelos y crear la entidad

part of infraestructure.mappers;

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB movieDB) => Movie(
        adult: movieDB.adult,
        backdropPath:
            (movieDB.backdropPath != '' && movieDB.backdropPath != null)
                ? 'https://image.tmdb.org/t/p/w500${movieDB.backdropPath}'
                : 'https://sd.keepcalms.com/i/keep-calm-poster-not-found.png',
        genreIds: movieDB.genreIds.map((e) => e.toString()).toList(),
        id: movieDB.id,
        originalLanguage: movieDB.originalLanguage,
        originalTitle: movieDB.originalTitle,
        overview: movieDB.overview,
        popularity: movieDB.popularity,
        posterPath: (movieDB.posterPath != '' && movieDB.posterPath != null)
            ? 'https://image.tmdb.org/t/p/w500${movieDB.posterPath}'
            : 'https://www.movienewz.com/img/films/poster-holder.jpg',
        releaseDate: movieDB.releaseDate ?? DateTime.now(),
        title: movieDB.title,
        video: movieDB.video,
        voteAverage: movieDB.voteAverage,
        voteCount: movieDB.voteCount,
      );

  static Movie movieDetailsToEntity(MovieDetails movieDB) => Movie(
        adult: movieDB.adult,
        backdropPath: (movieDB.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movieDB.backdropPath}'
            : 'https://sd.keepcalms.com/i/keep-calm-poster-not-found.png',
        genreIds: movieDB.genres.map((e) => e.name).toList(),
        id: movieDB.id,
        originalLanguage: movieDB.originalLanguage,
        originalTitle: movieDB.originalTitle,
        overview: movieDB.overview,
        popularity: movieDB.popularity,
        posterPath: (movieDB.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movieDB.posterPath}'
            : 'https://sd.keepcalms.com/i/keep-calm-poster-not-found.png',
        releaseDate: movieDB.releaseDate,
        title: movieDB.title,
        video: movieDB.video,
        voteAverage: movieDB.voteAverage,
        voteCount: movieDB.voteCount,
      );
}

//TODO: el objetivo es Tomar la implementación especifica de themoviedb y que me sirva para transformarlo a mi entidad
