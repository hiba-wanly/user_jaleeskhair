class RatingBook {
  int? id;
  int? userId;
  int? globalBookEditionId;
  int? rating;
  String? title;
  String? description;
  dynamic spoiler;
  dynamic public;
  int? deleted;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  RatingBook(
      {
        this.id,
        this.userId,
        this.globalBookEditionId,
        this.rating,
        this.title,
        this.description,
        this.spoiler,
        this.public,
        this.deleted,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  RatingBook.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    globalBookEditionId = json['global_book_edition_id'];
    rating = json['rating'];
    title = json['title'];
    description = json['description'];
    spoiler = json['spoiler'];
    public = json['public'];
    deleted = json['deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['global_book_edition_id'] = this.globalBookEditionId;
    data['rating'] = this.rating;
    data['title'] = this.title;
    data['description'] = this.description;
    data['spoiler'] = this.spoiler;
    data['public'] = this.public;
    data['deleted'] = this.deleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
