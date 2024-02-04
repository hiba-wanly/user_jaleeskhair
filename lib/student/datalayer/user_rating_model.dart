class UserRatingModel {
  int? id;
  dynamic globalBookEditionId;
  dynamic rating;
  dynamic title;
  dynamic description;
  dynamic spoiler;
  dynamic public;

  UserRatingModel(
      {this.id,
        this.globalBookEditionId,
        this.rating,
        this.title,
        this.description,
        this.spoiler,
        this.public});

  UserRatingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    globalBookEditionId = json['global_book_edition_id'];
    rating = json['rating'] ;
    title = json['title'];
    description = json['description'];
    spoiler = json['spoiler'];
    public = json['public'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['global_book_edition_id'] = this.globalBookEditionId;
    data['rating'] = this.rating;
    data['title'] = this.title;
    data['description'] = this.description;
    data['spoiler'] = this.spoiler;
    data['public'] = this.public;
    return data;
  }
}