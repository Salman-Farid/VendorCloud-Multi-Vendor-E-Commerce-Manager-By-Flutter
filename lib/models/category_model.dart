class Category {
  String? status;
  int? total;
  List<Data>? data;

  Category({this.status, this.total, this.data});

  Category.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    total = json['total'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  Image? image;
  String? sId;
  String? name;
  String? shippingCharge;
  String? vat;
  String? status;
  String? commission;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<SubCategories>? subCategories;
  String? id;

  Data(
      {this.image,
        this.sId,
        this.name,
        this.shippingCharge,
        this.vat,
        this.status,
        this.commission,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.subCategories,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    sId = json['_id'];
    name = json['name'];
    shippingCharge = json['shippingCharge'];
    vat = json['vat'];
    status = json['status'];
    commission = json['commission'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    if (json['subCategories'] != null) {
      subCategories = <SubCategories>[];
      json['subCategories'].forEach((v) {
        subCategories!.add(new SubCategories.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['shippingCharge'] = this.shippingCharge;
    data['vat'] = this.vat;
    data['status'] = this.status;
    data['commission'] = this.commission;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.subCategories != null) {
      data['subCategories'] =
          this.subCategories!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}

class Image {
  String? publicId;
  String? secureUrl;

  Image({this.publicId, this.secureUrl});

  Image.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    secureUrl = json['secure_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['public_id'] = this.publicId;
    data['secure_url'] = this.secureUrl;
    return data;
  }
}

class SubCategories {
  String? sId;
  String? category;
  String? name;
  String? shippingCharge;
  String? vat;
  String? status;
  String? commission;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SubCategories(
      {this.sId,
        this.category,
        this.name,
        this.shippingCharge,
        this.vat,
        this.status,
        this.commission,
        this.createdAt,
        this.updatedAt,
        this.iV});

  SubCategories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    category = json['category'];
    name = json['name'];
    shippingCharge = json['shippingCharge'];
    vat = json['vat'];
    status = json['status'];
    commission = json['commission'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['category'] = this.category;
    data['name'] = this.name;
    data['shippingCharge'] = this.shippingCharge;
    data['vat'] = this.vat;
    data['status'] = this.status;
    data['commission'] = this.commission;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
