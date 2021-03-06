import 'package:flutter/material.dart';

class GuidData {
  final String name, phone, type, logo, place;
  final Color color;

  GuidData(
      {required this.name,
      required this.phone,
      required this.type,
      required this.logo,
      required this.place,
      required this.color});
}

List<GuidData> guidList = [
  GuidData(
      name: 'شركة الإتحاد',
      phone: '01009450642',
      place: 'المنصورة',
      logo: 'unit.jpg',
      type: 'U-PVC',
      color: Colors.green.shade300),
  GuidData(
      name: 'شركة تريج',
      phone: '01002258441',
      place: 'التجمع',
      logo: 'treeg.jpg',
      type: 'U-PVC',
      color: Colors.indigo.shade300),
  GuidData(
      name: 'خالد عبودة',
      phone: '01117706341',
      place: 'الشرقاوية',
      logo: 'abouda.jpg',
      type: 'زجاج',
      color: Colors.orange.shade300),
  GuidData(
      name: 'الحامد شتر',
      phone: '01200928299',
      place: 'المرج',
      logo: 'hamed.png',
      type: 'وكيل شيش حصيرة',
      color: Colors.amber),
  GuidData(
      name: 'الشرقاوي',
      phone: '01063070485',
      place: 'الدلتا',
      logo: 'sharq.jpg',
      type: 'وكيل pvc - شركة وينتك',
      color: Colors.white),
  GuidData(
      name: ' للرخام الصناعي',
      phone: '01000885476',
      place: 'المنصورة',
      logo: 'city.png',
      type: 'رخام صناعي',
      color: Colors.indigo),
  GuidData(
      name: 'للتصنيع والتوريدات',
      phone: '01033894104',
      place: 'شحن',
      logo: 'ola.png',
      type: 'اكسسوارات',
      color: Colors.red),
  GuidData(
      name: 'شركة الشويمي',
      phone: '01008668683',
      place: 'المحلة',
      logo: 'shweme.png',
      type: 'ألومنيوم واكسسوار',
      color: Colors.yellow),
  GuidData(
      name: 'كوهية شتر باور',
      phone: '01554056412',
      place: 'السلام - الساحل الشمالي',
      logo: 'qushutter.jpg',
      type: 'شيش حصيرة',
      color: Colors.yellow),
  GuidData(
      name: 'واجهات',
      phone: '01099399187',
      place: 'مدينة نصر',
      logo: 'waga.jpg',
      type: 'واجهات',
      color: Colors.blueAccent),
  GuidData(
      name: 'شركة الصقر',
      phone: '01096660866',
      place: 'مدينة نصر',
      logo: 'saqr.jpg',
      type: 'أبواب مصفحة',
      color: Colors.orange.shade300),
  GuidData(
      name: 'القرشي',
      phone: '01119932111',
      place: 'طنطا',
      logo: 'korashy.jpg',
      type: 'ألومنيوم وU-PVC',
      color: Colors.indigo),
  GuidData(
      name: 'ويل موكس البنا',
      phone: '01060300850',
      place: 'دمياط',
      logo: 'bana.jpg',
      type: 'أكسسوار استانلس',
      color: Colors.blue),
  GuidData(
      name: 'الحمــد',
      phone: '01112456214',
      place: 'مؤسسة الزكاة',
      logo: 'hamed.jpg',
      type: 'صيانة منشار',
      color: Colors.teal.shade400),
  GuidData(
      name: 'كواليتي شتر',
      phone: '01008622077',
      place: 'الأسكندرية',
      logo: 'qu.png',
      type: 'شيش حصيرة',
      color: Colors.red.shade300),
  GuidData(
      name: 'نايل تال',
      phone: '01113703217',
      place: 'مؤسسة الزكاة',
      logo: 'nile.jpg',
      type: 'شيش حصيرة',
      color: Colors.blueGrey.shade300),
  GuidData(
      name: 'أحمد عطية',
      phone: '01120972004',
      place: 'النزهة 2',
      logo: 'flyscreen.jpg',
      type: 'سلك بيليسية',
      color: Colors.green.shade300),
  GuidData(
      name: 'شركة الندي',
      phone: '01095262859',
      place: 'عين شمس',
      logo: 'nada.jpg',
      type: 'إكسسوار ألومنيوم',
      color: Colors.purple.shade300),
  GuidData(
      name: 'زاد الخير',
      phone: '01066400140',
      place: 'المنصورة',
      logo: 'zad.png',
      type: 'بولي لاك',
      color: Colors.orange.shade300),
  GuidData(
      name: 'شركة الطارق',
      phone: '01222304769',
      place: 'الأسكندرية',
      logo: 'tc.png',
      type: 'ماكينات ومعدات',
      color: Colors.grey.shade400),
  GuidData(
      name: 'الدولية',
      phone: '01277211552',
      place: '6 أكتوبر',
      logo: 'dawlia.jpg',
      type: 'دهانات',
      color: Colors.yellow.shade300),
  GuidData(
      name: 'القباري',
      phone: '01066876680',
      place: 'الأسكندرية',
      logo: 'qwqw.jpg',
      type: 'ألومنيوم',
      color: Colors.red),
  GuidData(
      name: 'ألترا ميتال',
      phone: '01027556733',
      place: 'مؤسسة الزكاة',
      logo: 'alumil.jpg',
      type: 'وكيل ألوميل',
      color: Colors.orange.shade300),
  GuidData(
      name: 'كيتشن درو',
      phone: '01061753377',
      place: 'إلكتروني',
      logo: 'kitchendraw.jpg',
      type: 'برنامج تصميم',
      color: Colors.teal.shade300),
  GuidData(
      name: 'كريتيف تاتش',
      phone: '01207621906',
      place: 'مدينة نصر',
      logo: 'creative.jpg',
      type: 'رخام صناعي',
      color: Colors.green.shade300),
  GuidData(
      name: 'علم الدين',
      phone: '01022999022',
      place: 'المنصورة',
      logo: 'alam.png',
      type: 'فايبر وكلادينج',
      color: Colors.red),
];
