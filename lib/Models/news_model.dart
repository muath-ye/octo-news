// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
    NewsModel({
        this.status,
        this.totalResults,
        this.articles,
    });

    String? status;
    int? totalResults;
    List<Article>? articles;

    factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        status: json["status"] == null ? null : json["status"],
        totalResults: json["totalResults"] == null ? null : json["totalResults"],
        articles: json["articles"] == null ? null : List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "totalResults": totalResults == null ? null : totalResults,
        "articles": articles == null ? null : List<dynamic>.from(articles!.map((x) => x.toJson())),
    };
}

class Article {
    Article({
        this.source,
        this.author,
        this.title,
        this.description,
        this.url,
        this.urlToImage,
        this.publishedAt,
        this.content,
    });

    Source? source;
    String? author;
    String? title;
    String? description;
    String? url;
    String? urlToImage;
    DateTime? publishedAt;
    String? content;

    factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: json["source"] == null ? null : Source.fromJson(json["source"]),
        author: json["author"] == null ? null : json["author"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        url: json["url"] == null ? null : json["url"],
        urlToImage: json["urlToImage"] == null ? null : json["urlToImage"],
        publishedAt: json["publishedAt"] == null ? null : DateTime.parse(json["publishedAt"]),
        content: json["content"] == null ? null : json["content"],
    );

    Map<String, dynamic> toJson() => {
        "source": source == null ? null : source!.toJson(),
        "author": author == null ? null : author,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "url": url == null ? null : url,
        "urlToImage": urlToImage == null ? null : urlToImage,
        "publishedAt": publishedAt == null ? null : publishedAt!.toIso8601String(),
        "content": content == null ? null : content,
    };
}

class Source {
    Source({
        this.id,
        this.name,
    });

    Id? id;
    String? name;

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"] == null ? null : idValues.map[json["id"]],
        name: json["name"] == null ? null : json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : idValues.reverse[id],
        "name": name == null ? null : name,
    };
}

enum Id { WIRED, REUTERS, BUSINESS_INSIDER }

final idValues = EnumValues({
    "business-insider": Id.BUSINESS_INSIDER,
    "reuters": Id.REUTERS,
    "wired": Id.WIRED
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
