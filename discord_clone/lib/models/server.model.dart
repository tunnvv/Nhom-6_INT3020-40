class Server {
  final String id;
  final String name;
  final String createdAt;

  const Server({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory Server.fromJson(Map<String, dynamic> json) {
    return Server(
      id: json['_id'],
      name: json['name'],
      createdAt: json['createdAt'],
    );
  }
}
