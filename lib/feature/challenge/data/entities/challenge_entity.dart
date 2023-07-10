import 'package:ecohero/feature/feature.dart';

class ChallengeEntity {
  ChallengeEntity({
    required this.title,
    required this.image,
    required this.imageIll,
    required this.desc,
    required this.act,
    required this.poin,
  });

  final String title;
  final String image;
  final String imageIll;
  final String desc;
  final List<String> act;
  final int poin;

  static List<ChallengeEntity> challengesEntity = [
    ChallengeEntity(
      title: 'Transportasi',
      image: AppIllustration.mockImage,
      imageIll: AppIllustration.car,
      desc:
          'Challenge ini bertujuan untuk mengurangi emisi gas buang dari kendaraan bermotor yang berkontribusi terhadap polusi udara. Kegiatan yang direkomendasikan adalah:',
      act: [
        "Menggunakan kendaraan umum, sepeda, atau berjalan kaki sebagai alternatif transportasi.",
        "Melakukan servis rutin dan perawatan kendaraan untuk memastikan mesin dan knalpot berfungsi dengan baik.",
        "Menghindari menghidupkan mesin kendaraan saat berhenti atau parkir dalam waktu lama.",
        "Memilih bahan bakar yang ramah lingkungan dan hemat energi.",
      ],
      poin: 4,
    ),
    ChallengeEntity(
      title: 'Asap Pabrik',
      image: AppIllustration.factoryPollution,
      imageIll: AppIllustration.factory,
      desc:
          'Challenge ini bertujuan untuk mengurangi emisi gas buang dari pabrik-pabrik industri yang menyebabkan polusi udara. Kegiatan yang direkomendasikan adalah:',
      act: [
        "Melakukan kampanye kesadaran lingkungan dan sosialisasi tentang dampak polusi udara bagi kesehatan dan lingkungan.",
        "Menanam tanaman penangkal polusi di sekitar rumah atau lingkungan Anda",
        "Memilih produk hemat daya dan ramah lingkungan",
      ],
      poin: 3,
    ),
    ChallengeEntity(
      title: 'Listrik Terbuang',
      image: AppIllustration.wasteElectric,
      imageIll: AppIllustration.lamp,
      desc:
          'Challenge ini bertujuan untuk mengurangi konsumsi listrik yang berlebihan dan tidak efisien yang menyebabkan polusi udara. Kegiatan yang direkomendasikan adalah:',
      act: [
        "Menggunakan lampu hemat energi seperti LED atau CFL dan mematikan lampu saat tidak digunakan.",
        "Mengatur suhu AC sesuai dengan kebutuhan dan membersihkan filter AC secara rutin.",
        "Memilih peralatan elektronik yang hemat energi dan memiliki label energi hijau.",
        "Memanfaatkan sumber energi terbarukan seperti matahari, angin, atau air sebagai alternatif pembangkit listrik.",
      ],
      poin: 2,
    ),
    ChallengeEntity(
      title: 'Asap Hasil Pembakaran',
      image: AppIllustration.burningPollution,
      imageIll: AppIllustration.burning,
      desc:
          'Challenge ini bertujuan untuk mengurangi pembakaran sampah, daun kering, atau bahan lain yang menghasilkan asap dan polusi udara. Kegiatan yang direkomendasikan adalah:',
      act: [
        "Memilah sampah organik dan anorganik dan mendaur ulang atau mengompos sampah organik.",
        "Menggunakan metode pengolahan sampah tanpa bakar seperti pirolisis, gasifikasi, atau plasmafikasi.",
        "Menyiram daun kering atau ranting sebelum membuangnya agar tidak mudah terbakar.",
        "Menghindari membakar lilin, dupa, atau kemenyan di dalam ruangan dan menggunakan penyaring udara jika perlu.",
      ],
      poin: 2,
    ),
  ];
}

// . Tanaman seperti lidah buaya, lidah mertua, atau palem kipas dapat menyerap polutan dan menghasilkan oksigen1.
// Memilih produk hemat daya dan ramah lingkungan yang berasal dari pabrik yang menerapkan teknologi bersih dan efisien dalam proses produksi dan pembuangan limbah1