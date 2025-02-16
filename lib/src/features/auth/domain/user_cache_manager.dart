class UserCacheManager {
  // Singleton instance
  static final UserCacheManager _instance = UserCacheManager._internal();
  factory UserCacheManager() => _instance;
  UserCacheManager._internal();

  // Cache settings
  final Duration _cacheExpiry = const Duration(minutes: 30);
  final int _maxCacheSize = 100;

  // Cache entries with timestamps
  final Map<String, ({DateTime timestamp, Map<String, dynamic> data})> _cache =
      {};

  // Add data to cache
  void cacheUser(String userId, Map<String, dynamic> data) {
    // Remove oldest entries if cache is full
    if (_cache.length >= _maxCacheSize) {
      _removeOldestEntries();
    }

    _cache[userId] = (
      timestamp: DateTime.now(),
      data: Map.from(data),
    );
  }

  // Get cached data
  Map<String, dynamic>? getCachedUser(String userId) {
    final entry = _cache[userId];
    if (entry == null) return null;

    // Check if cache has expired
    if (DateTime.now().difference(entry.timestamp) > _cacheExpiry) {
      _cache.remove(userId);
      return null;
    }

    return Map.from(entry.data);
  }

  // Remove oldest entries when cache is full
  void _removeOldestEntries() {
    if (_cache.isEmpty) return;

    final entries = _cache.entries.toList()
      ..sort((a, b) => a.value.timestamp.compareTo(b.value.timestamp));

    // Remove oldest 20% of entries
    final entriesToRemove = (entries.length * 0.2).ceil();
    for (var i = 0; i < entriesToRemove; i++) {
      _cache.remove(entries[i].key);
    }
  }

  // Clear expired cache entries
  void cleanCache() {
    final now = DateTime.now();
    _cache.removeWhere(
        (key, value) => now.difference(value.timestamp) > _cacheExpiry);
  }

  // Clear all cache
  void clearCache() {
    _cache.clear();
  }
}
