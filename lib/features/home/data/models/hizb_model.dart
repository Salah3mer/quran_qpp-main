class HizbModel {
  final int surah;
  final int ayah;

  HizbModel({required this.surah, required this.ayah});

  factory HizbModel.fromJson(Map<String, dynamic> json) =>
      HizbModel(surah: json['surah'], ayah: json['ayah']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['surah'] = surah;
    data['ayah'] = ayah;
    return data;
  }
}
