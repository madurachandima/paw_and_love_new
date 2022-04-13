class SellerPostModel {
  String? sellerName;
  String? phoneNumber;
  String? city;
  String? address;
  String? itemName;
  String? description;
  String? imageUrl;
  bool? isAvailable;
  String? uid;
  String? price;
  List? searchQueryItemName;

  SellerPostModel(
      {this.sellerName,
      this.phoneNumber,
      this.city,
      this.address,
      this.itemName,
      this.description,
      this.imageUrl,
      this.isAvailable,
      this.uid,
      this.price,
      this.searchQueryItemName});

  Map<String, dynamic> toJson() => {
        'name': sellerName,
        'phone_number': phoneNumber,
        'city': city,
        'address': address,
        'item_name': itemName,
        'description': description,
        'image_url': imageUrl,
        'isAvailable': isAvailable,
        'user_id': uid,
        'price': price,
        'time_stamp': DateTime.now().millisecondsSinceEpoch,
        'searchQueryItemName': searchQueryItemName
      };
}
