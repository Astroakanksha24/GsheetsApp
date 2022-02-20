import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

List<Client> allPostsFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Client>.from(jsonData.map((x) => Post.fromJson(x)));
}

class Post {
  Post({
    required this.clients,
  });

  List<Client> clients;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        clients:
            List<Client>.from(json["clients"].map((x) => Client.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "clients": List<dynamic>.from(clients.map((x) => x.toJson())),
      };
}

class Client {
  String name;
  String? id;
  String? company;
  String? orderId;
  String? invoicepaid;
  String? invoicePending;

  Client({
    this.name,
    this.id,
    this.company,
    this.orderId,
    this.invoicepaid,
    this.invoicePending,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        name: json["name"],
        id: json["id"],
        company: json["company"],
        orderId: json["orderId"],
        invoicepaid: json["invoicepaid"],
        invoicePending: json["invoicePending"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "company": company,
        "orderId": orderId,
        "invoicepaid": invoicepaid,
        "invoicePending": invoicePending,
      };
}
