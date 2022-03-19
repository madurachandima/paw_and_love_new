const String imageAssetsRoot = "assets/img/";

final String breeders = _getImagePath('shop.jpg');
final String disease = _getImagePath('disease.jpg');
final String dogpPofile = _getImagePath('profile.jpg');
final String clinic = _getImagePath('vet.jpg');
final String addImage = _getImagePath('add_image.png');
final String sickDog = _getImagePath('sick_dog.png');
final String chatbot = _getImagePath("chatbot.png");
final String dogImage = _getImagePath("dog.png");
final String doctorProfile = _getImagePath("doctor_profile.png");
final String sellerProfile = _getImagePath("seller_profile.png");

String _getImagePath(String filename) {
  return imageAssetsRoot + filename;
}
