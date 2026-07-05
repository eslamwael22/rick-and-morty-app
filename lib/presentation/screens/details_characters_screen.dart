import 'package:films_project/Data/models/characters_model.dart';
import 'package:films_project/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class DetailsCharactersScreen extends StatefulWidget {
  final CharactersModel character;

  const DetailsCharactersScreen({super.key, required this.character});

  @override
  State<DetailsCharactersScreen> createState() =>
      _DetailsCharactersScreenState();
}

class _DetailsCharactersScreenState extends State<DetailsCharactersScreen> {
  // ✅ نفس اللون المستخدم في باقي الصفحات
  static const Color backgroundColor = Color(0xFF1A1A2E);
  static const Color cardColor = Color(0xFF22223B);

  late final Future<List<EpisodeModel>> _episodesFuture;

  @override
  void initState() {
    super.initState();
    _episodesFuture = _fetchEpisodes(widget.character.episodeUrls);
  }

  Future<List<EpisodeModel>> _fetchEpisodes(List<String> urls) async {
    if (urls.isEmpty) return [];

    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    final episodes = <EpisodeModel>[];
    const maxConcurrent = 3;

    for (int i = 0; i < urls.length; i += maxConcurrent) {
      final batch = urls.sublist(i, (i + maxConcurrent).clamp(0, urls.length));

      try {
        final futures = batch.map((url) => _fetchSingleEpisode(dio, url));
        final results = await Future.wait(futures);
        episodes.addAll(results.whereType<EpisodeModel>());

        if (i + maxConcurrent < urls.length) {
          await Future.delayed(const Duration(milliseconds: 500));
        }
      } catch (e) {
        print('Error fetching episode batch: $e');
      }
    }

    return episodes;
  }

  Future<EpisodeModel?> _fetchSingleEpisode(Dio dio, String url) async {
    try {
      final response = await dio.get(url);
      final data = response.data as Map<String, dynamic>;
      return EpisodeModel(
        name: data['name'] ?? 'Unknown episode',
        airDate: data['air_date'] ?? 'Unknown date',
        episode: data['episode'] ?? 'Unknown',
      );
    } catch (e) {
      print('Failed to fetch episode from $url: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final character = widget.character;

    return Scaffold(
      backgroundColor: backgroundColor, // ✅ نفس لون باقي الصفحات
      appBar: AppBar(
        backgroundColor:
            backgroundColor, // ✅ يمنع وجود شريط فاتح فوق خلفية غامقة
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ), // ✅ زرار الرجوع يبقى واضح
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                'Character Details',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    character.image,
                    height: 220,
                    width: 220,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                character.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // ✅ واضح فوق الخلفية الغامقة
                ),
              ),
              const SizedBox(height: 8),
              _infoRow('Status', character.status),
              _infoRow('Species', character.species),
              _infoRow('Gender', character.gender),
              _infoRow(
                'Type',
                character.type.isEmpty ? 'Unknown' : character.type,
              ),
              _infoRow('Origin', character.origin.name),
              const SizedBox(height: 20),
              const Text(
                'Episodes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // ✅ واضح فوق الخلفية الغامقة
                ),
              ),
              const SizedBox(height: 8),
              FutureBuilder<List<EpisodeModel>>(
                future: _episodesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade900.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'تعذر تحميل الحلقات. الرجاء المحاولة لاحقاً.',
                        style: TextStyle(
                          color: Colors.red.shade200,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }

                  final episodes = snapshot.data ?? [];
                  if (episodes.isEmpty) {
                    return const Text(
                      'لا توجد حلقات متوفرة',
                      style: TextStyle(color: Colors.white70),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: episodes.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final episode = episodes[index];
                      return Card(
                        color: cardColor, // ✅ لون الكارد بدل الأبيض الافتراضي
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(
                            episode.name,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            '${episode.episode} • ${episode.airDate}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white, // ✅ واضح فوق الخلفية الغامقة
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white70,
              ), // ✅ درجة أفتح شوية للتمييز عن الـ label
            ),
          ),
        ],
      ),
    );
  }
}

class EpisodeModel {
  final String name;
  final String airDate;
  final String episode;

  EpisodeModel({
    required this.name,
    required this.airDate,
    required this.episode,
  });
}
