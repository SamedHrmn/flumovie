part of '../presentation/search_movie_view.dart';

class _SearchResultCard extends StatelessWidget {
  const _SearchResultCard({required this.movieSearchDetail});

  final MovieSearchDetail movieSearchDetail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigationManager.instance.go(
        des: FluNavigations.movieDetailView,
        param: movieSearchDetail.id,
      ),
      child: SizedBox(
        width: 100,
        height: 220,
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 16,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: FluNetworkImage(
                  url: movieSearchDetail.posterPath,
                  fit: BoxFit.fill,
                  radius: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
