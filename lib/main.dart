import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class Student {
  String name;
  double? score;

  Student(this.name, this.score);
}


String xepLoai(double diem) {
  if (diem < 0 || diem > 10) {
    return 'Không hợp lệ';
  } else if (diem >= 8.0) {
    return 'Giỏi';
  } else if (diem >= 6.5) {
    return 'Khá';
  } else if (diem >= 5.0) {
    return 'Trung bình';
  } else {
    return 'Yếu';
  }
}

Color mauChu(String loai) {
  if (loai == 'Giỏi') {
    return Colors.green;
  } else if (loai == 'Khá') {
    return Colors.blue;
  } else if (loai == 'Trung bình') {
    return Colors.orange;
  } else if (loai == 'Yếu') {
    return Colors.red;
  } else {
    return Colors.grey;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    List<Student> ds = [
      Student('Nguyễn Văn An', 9.0),
      Student('Trần Thị Bình', 7.2),
      Student('Lê Minh Chi', null),
      Student('Phạm Quốc Dũng', 4.5),
      Student('Võ Thanh Em', 5.8),
    ];


    double tong = 0;
    int soCoDiem = 0;
    int soGioi = 0;
    int soChuaCoDiem = 0;
    double caoNhat = 0;

    for (Student s in ds) {
      if (s.score == null) {
        soChuaCoDiem++;
      } else {
        tong += s.score!;
        soCoDiem++;
        if (s.score! >= 8.0) {
          soGioi++;
        }
        if (s.score! > caoNhat) {
          caoNhat = s.score!;
        }
      }
    }

    double diemTB = 0;
    if (soCoDiem > 0) {
      diemTB = tong / soCoDiem;
    }


    List<Widget> dong = [];
    for (Student s in ds) {
      String diemText;
      String loai;
      if (s.score == null) {
        diemText = '—';
        loai = 'Chưa có điểm';
      } else {
        diemText = s.score.toString();
        loai = xepLoai(s.score!);
      }

      dong.add(
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(loai, style: TextStyle(color: mauChu(loai))),
                ],
              ),
              Text(
                diemText,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('Bảng điểm lớp'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Colors.indigo,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Điểm trung bình lớp',
                      style: TextStyle(color: Colors.white70),
                    ),
                    Text(
                      diemTB.toStringAsFixed(2),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Giỏi: $soGioi',
                            style: const TextStyle(color: Colors.white)),
                        Text('Chưa có điểm: $soChuaCoDiem',
                            style: const TextStyle(color: Colors.white)),
                        Text('Cao nhất: $caoNhat',
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text('DANH SÁCH - ${ds.length} SINH VIÊN'),
              const SizedBox(height: 8),


              Column(children: dong),
            ],
          ),
        ),
      ),
    );
  }
}