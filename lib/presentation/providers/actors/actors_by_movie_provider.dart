part of presentation.provider.actors;

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsBymovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  ActorsBymovieNotifier({required this.getActors}) : super({});

  final GetActorsCallback getActors;

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;
    final actors = await getActors(movieId);

    state = {...state, movieId: actors};
  }
}

final StateNotifierProvider<ActorsBymovieNotifier, Map<String, List<Actor>>>
    actorsByMovieProvider =
    StateNotifierProvider<ActorsBymovieNotifier, Map<String, List<Actor>>>(
  (ref) {
    final fetchActors = ref.watch(actorRepositoryProvider).getActorsBymovie;
    return ActorsBymovieNotifier(getActors: fetchActors);
  },
);
