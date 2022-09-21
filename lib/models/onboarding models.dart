class BoardingModel {
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

List<BoardingModel> model = [
  BoardingModel(
      image: "images/onboarding 1.png",
      title: 'Are You Redy?',
      body: 'Now you can make shopping with your phone.'),
  BoardingModel(
      image: "images/onboarding 2.png",
      title: 'Beautiful Items To Buy!',
      body: 'There is many category and too many items.'),
  BoardingModel(
      image: "images/onboarding 3.png",
      title: 'Credit Card!',
      body: 'You can pay with credit card.'),
];
