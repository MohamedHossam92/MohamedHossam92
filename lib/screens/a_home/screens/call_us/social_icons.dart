class SocialIcons {
  final String imagePath, link;

  SocialIcons({required this.imagePath, required this.link});
}

List<SocialIcons> socialList = [
  SocialIcons(imagePath: 'facebook', link: 'https://m.facebook.com/SwTalapp'),
  SocialIcons(imagePath: 'insta', link: 'http://instagram.com'),
  SocialIcons(
      imagePath: 'youtube',
      link: 'https://www.youtube.com/channel/UCESDMmxlScStWZAy4cm8nuw'),
  SocialIcons(imagePath: 'twitter', link: 'http://twitter.com'),
  SocialIcons(imagePath: 'linked', link: 'http://linkedin.com'),
];
