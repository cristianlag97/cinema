part of infraestructure.models.moviedb;

class MovieDbResponse {
  MovieDbResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final Dates dates;
  final int page;
  final List<MovieMovieDB> results;
  final int totalPages;
  final int totalResults;

  MovieDbResponse.fromJson(Map<String, dynamic> json)
      : dates = json['dates'] != null
            ? Dates.fromJson(json["dates"])
            : Dates(maximum: DateTime.now(), minimum: DateTime.now()),
        page = json["page"],
        results = json["results"] != null
            ? List<MovieMovieDB>.from(
                json["results"].map((x) => MovieMovieDB.fromJson(x)))
            : [],
        totalPages = json["total_pages"],
        totalResults = json["total_results"];

  Map<String, dynamic> toJson() => {
        "dates": dates.toJson(),
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
