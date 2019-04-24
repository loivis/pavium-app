class Config {
  final String env;
  final String endpoint;

  static Config singleton;

  factory Config(String env, endpoint) {
    if (singleton == null) {
      singleton = Config._internal(env, endpoint);
    }

    return singleton;
  }

  Config._internal(this.env, this.endpoint);
}
