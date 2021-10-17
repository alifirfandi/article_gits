import 'dart:convert';

List<SearchArticles> searchArticlesFromJson(String str) =>
    List<SearchArticles>.from(
        json.decode(str).map((x) => SearchArticles.fromJson(x)));

String searchArticlesToJson(List<SearchArticles> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchArticles {
  SearchArticles({
    required this.id,
    required this.title,
    required this.url,
    required this.type,
    required this.subtype,
    required this.links,
  });

  int id;
  String title;
  String url;
  String type;
  String subtype;
  Links links;

  factory SearchArticles.fromJson(Map<String, dynamic> json) => SearchArticles(
        id: json["id"],
        title: json["title"],
        url: json["url"],
        type: json["type"],
        subtype: json["subtype"],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "url": url,
        "type": type,
        "subtype": subtype,
        "_links": links.toJson(),
      };
}

class Links {
  Links({
    required this.self,
    required this.about,
    required this.collection,
  });

  List<Self> self;
  List<About> about;
  List<About> collection;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: List<Self>.from(json["self"].map((x) => Self.fromJson(x))),
        about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
        collection:
            List<About>.from(json["collection"].map((x) => About.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self.map((x) => x.toJson())),
        "about": List<dynamic>.from(about.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
      };
}

class About {
  About({
    required this.href,
  });

  String href;

  factory About.fromJson(Map<String, dynamic> json) => About(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

class Self {
  Self({
    required this.embeddable,
    required this.href,
  });

  bool embeddable;
  String href;

  factory Self.fromJson(Map<String, dynamic> json) => Self(
        embeddable: json["embeddable"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "embeddable": embeddable,
        "href": href,
      };
}
