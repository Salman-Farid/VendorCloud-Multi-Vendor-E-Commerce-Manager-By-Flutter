

// class Product {
//   String? status;
//   int? total;
//   List<Data>? data;
//
//   Product({this.status, this.total, this.data});
//
//   Product.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     total = json['total'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['status'] = this.status;
//     data['total'] = this.total;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }



class allProduct {
  String? status;
  int? total;
  List<Product>? data;

  allProduct({this.status, this.total, this.data});

  allProduct.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] is List) {
      total = json['total'];
      data = <Product>[];
      json['data'].forEach((v) {
        data!.add(Product.fromJson(v));
      });
    } else if (json['data'] is Map) {
      data = [Product.fromJson(json['data'])];
    } else if (json['data'] is String) {
      // Handle the case where data is a String
      data = [Product(name: json['data'])];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    if (this.data != null && this.data!.length > 1) {
      data['total'] = total;
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    } else if (this.data != null && this.data!.length == 1) {
      data['data'] = this.data!.first.toJson();
    }
    return data;
  }
}


class Product {

  dynamic?  video;
  String? customId;
  dynamic? user;
  String? name;
  String? slug;
  int? price;
  int? quantity;
  String? summary;
  String? description;
  String? category;
  String? brand;
  dynamic? coverPhoto;
  List<dynamic>? images;
  int? stock;
  int? sold;
  int? revenue;
  List<dynamic>? numReviews;
  int? ratings;
  Specifications? specifications;
  List<dynamic>? likes;
  String? subCategory;
  String? warranty;
  Packaging? packaging;

  String? sId;
  String? createdAt;
  String? updatedAt;
  int? V;
  List<Reviews>? reviews;
  String? id;





  Product({
    this.coverPhoto,
    this.video,
    this.specifications,
    this.sId,
    this.customId,
    this.user,
    this.name,
    this.slug,
    this.price,
    this.quantity,
    this.summary,
    this.description,
    this.category,
    this.brand,
    this.images,
    this.stock,
    this.sold,
    this.revenue,
    this.numReviews,
    this.ratings,
    this.likes,
    this.createdAt,
    this.updatedAt,
    this.V,
    this.reviews,
    this.id,
    this.subCategory,
    this.warranty,
    this.packaging,
  });



  Product.fromJson(Map<String, dynamic> json) {
    coverPhoto = json['coverPhoto'] != null ? CoverPhoto.fromJson(json['coverPhoto']) : null;
    video = json['video'] != null ? CoverPhoto.fromJson(json['video']) : null;
    specifications = json['specifications'] != null
        ? Specifications.fromJson(json['specifications'])
        : null;
    sId = json['_id'];
    customId = json['customId'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    name = json['name'];
    slug = json['slug'];
    price = json['price'];
    quantity = json['quantity'];
    summary = json['summary'];
    warranty = json['warranty'];
    description = json['description'];
    category = json['category'];
    brand = json['brand'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v ?? {}));
      });
    }
    stock = json['stock'];
    sold = json['sold'];
    revenue = json['revenue'];
    if (json['numReviews'] != null) {
      numReviews = <dynamic>[];
      json['numReviews'].forEach((v) {
        numReviews!.add(v);
      });
    }
    ratings = json['ratings'];
    if (json['likes'] != null) {
      likes = <dynamic>[];
      json['likes'].forEach((v) {
        likes!.add(v);
      });
    }
    //packaging = json['packaging'] != null ? Packaging.fromJson(json['packaging']) : null;
    packaging= json["packaging"] == null ? null : Packaging.fromJson(json["packaging"]);

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v ?? {}));
      });
    }
    id = json['id'];
  }





  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (coverPhoto != null) {
      data['coverPhoto'] = coverPhoto;
    }
    if (video != null) {
      data['video'] = video;
    }
    if (specifications != null) {
      data['specifications'] = specifications!.toJson();
    }
    data['user'] = user;
    data['name'] = name;
    data['slug'] = slug;
    data['price'] = price;
    data['quantity'] = quantity;
    data['summary'] = summary;
    data['description'] = description;
    data['category'] = category;
    data['subCategory'] = subCategory;
    data['brand'] = brand;
    data['warranty'] = warranty;
    data['packaging'] = packaging;

    if (images != null) {
      data['images'] = images;
    }
    data['stock'] = stock;
    data['sold'] = sold;
    return data;
  }
}

class CoverPhoto {
  String? publicId;
  String? secureUrl;

  CoverPhoto({this.publicId, this.secureUrl});

  CoverPhoto.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    secureUrl = json['secure_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['public_id'] = publicId;
    data['secure_url'] = secureUrl;
    return data;
  }
}

class Specifications {
  String? screenSize;
  String? batteryLife;
  String? cameraResolution;
  String? storageCapacity;
  String? os;
  String? size;
  String? material;
  String? gender;
  String? color;

  Specifications({
    this.screenSize,
    this.batteryLife,
    this.cameraResolution,
    this.storageCapacity,
    this.os,
    this.size,
    this.material,
    this.gender,
    this.color,
  });

  Specifications.fromJson(Map<String, dynamic> json) {
    screenSize = json['screenSize'];
    batteryLife = json['batteryLife'];
    cameraResolution = json['cameraResolution'];
    storageCapacity = json['storageCapacity'];
    os = json['os'];
    size = json['size'];
    material = json['material'];
    gender = json['gender'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['screenSize'] = screenSize;
    data['batteryLife'] = batteryLife;
    data['cameraResolution'] = cameraResolution;
    data['storageCapacity'] = storageCapacity;
    data['os'] = os;
    data['size'] = size;
    data['material'] = material;
    data['gender'] = gender;
    data['color'] = color;
    return data;
  }
}

class User {
  CoverPhoto? avatar;
  Location? location;
  String? sId;
  String? name;
  String? email;
  String? role;
  bool? isActive;
  bool? isVerified;
  String? phone;
  String? gender;
  List<dynamic>? likes;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User({
    this.avatar,
    this.location,
    this.sId,
    this.name,
    this.email,
    this.role,
    this.isActive,
    this.isVerified,
    this.phone,
    this.gender,
    this.likes,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  User.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'] != null ? CoverPhoto.fromJson(json['avatar']) : null;
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    isActive = json['isActive'];
    isVerified = json['isVerified'];
    phone = json['phone'];
    gender = json['gender'];
    if (json['likes'] != null) {
      likes = <dynamic>[];
      json['likes'].forEach((v) {
        likes!.add(v);
      });
    }
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (avatar != null) {
      data['avatar'] = avatar!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['role'] = role;
    data['isActive'] = isActive;
    data['isVerified'] = isVerified;
    data['phone'] = phone;
    data['gender'] = gender;
    if (likes != null) {
      data['likes'] = likes;
    }
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Reviews {
  User? user;
  String? review;
  int? rating;
  List<dynamic>? likes;
  List<dynamic>? dislikes;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Reviews({
    this.user,
    this.review,
    this.rating,
    this.likes,
    this.dislikes,
    this.sId,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Reviews.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    review = json['review'];
    rating = json['rating'];
    if (json['likes'] != null) {
      likes = <dynamic>[];
      json['likes'].forEach((v) {
        likes!.add(v);
      });
    }
    if (json['dislikes'] != null) {
      dislikes = <dynamic>[];
      json['dislikes'].forEach((v) {
        dislikes!.add(v);
      });
    }
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['review'] = review;
    data['rating'] = rating;
    if (likes != null) {
      data['likes'] = likes;
    }
    if (dislikes != null) {
      data['dislikes'] = dislikes;
    }

    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Images {
  String? publicId;
  String? secureUrl;

  Images({this.publicId, this.secureUrl});

  Images.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    secureUrl = json['secure_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['public_id'] = publicId;
    data['secure_url'] = secureUrl;
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'] != null ? List<double>.from(json['coordinates']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['type'] = type;
    if (coordinates != null) {
      data['coordinates'] = coordinates;
    }
    return data;
  }
}


class Packaging {
  String? weight;
  String? height;
  String? width;
  String? dimension;

  Packaging({this.weight, this.height, this.width, this.dimension});

  Packaging.fromJson(Map<String, dynamic> json) {
    weight = json['weight'];
    height = json['height'];
    width = json['width'];
    dimension = json['dimension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weight'] = weight;
    data['height'] = height;
    data['width'] = width;
    data['dimension'] = dimension;
    return data;
  }
}