part of infraestructure.mappers;

class VideoMapper {
  static moviedbVideoToEntity(Result moviedbVideo) => Video(
      id: moviedbVideo.id,
      name: moviedbVideo.name,
      youtubeKey: moviedbVideo.key,
      publishedAt: moviedbVideo.publishedAt);
}
