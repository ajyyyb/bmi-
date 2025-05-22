import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xff0a0321),
        colorScheme: ColorScheme.dark(
          secondary: Colors.pink,
        ),
        textTheme: textTheme,
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          color: Color(0xff1d1e33),
        ),
      ),
      home: BMIInputScreen(),
    );
  }
}

class BMIInputScreen extends StatefulWidget {
  const BMIInputScreen({super.key});

  @override
  _BMIInputScreenState createState() => _BMIInputScreenState();
}

class _BMIInputScreenState extends State<BMIInputScreen> {
  bool isMale = true; // Пол (мужчина или женщина)
  double height = 160; // Рост
  int weight = 60; // Вес
  int age = 20; // Возраст

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        backgroundColor: Color(0xff0a0321), // Цвет AppBar
        elevation: 0, // Убираем тень
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildGenderSelection(),
            SizedBox(height: 40),
            _buildHeightSlider(),
            SizedBox(height: 40),
            _buildWeightAgeCounters(),
            SizedBox(height: 30),
            _buildCalculateButton(),
          ],
        ),
      ),
    );
  }

  // Выбор пола
  Widget _buildGenderSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildGenderButton('MALE', Icons.male, true),
        SizedBox(width: 30),
        _buildGenderButton('FEMALE', Icons.female, false),
      ],
    );
  }

  // Кнопка для выбора пола
  Widget _buildGenderButton(String text, IconData icon, bool gender) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isMale = gender;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 150,
        height: 177,
        decoration: BoxDecoration(
          color: isMale == gender ? Colors.blue : Color(0xff1d1e33), // Применение нового цвета
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isMale == gender ? Colors.white : Colors.grey, size: 100),
            SizedBox(height: 10),
            Text(
              text,
              style: TextStyle(
                color: isMale == gender ? Colors.white : Colors.grey,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Слайдер для роста
  Widget _buildHeightSlider() {
    return Container(
      width: double.infinity,
      height: 176,
      decoration: BoxDecoration(
        color: Color(0xff1d1e33), // Новый цвет для слайдера
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Height ${height.toStringAsFixed(1)} cm',
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          Slider(
            value: height,
            min: 100,
            max: 250,
            divisions: 150,
            label: height.toStringAsFixed(1),
            activeColor: Colors.pink, // Цвет активной части слайдера (красный)
            inactiveColor: Colors.grey, // Цвет неактивной части слайдера
            onChanged: (double newValue) {
              setState(() {
                height = newValue;
              });
            },
          ),
        ],
      ),
    );
  }

  // Контейнеры для веса и возраста
  Widget _buildWeightAgeCounters() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildWeightAgeContainer('Weight $weight kg', Icons.remove, Icons.add, () {
          setState(() {
            if (weight > 30) weight--;
          });
        }, () {
          setState(() {
            weight++;
          });
        }),
        SizedBox(width: 30),
        _buildWeightAgeContainer('Age $age', Icons.remove, Icons.add, () {
          setState(() {
            if (age > 10) age--;
          });
        }, () {
          setState(() {
            age++;
          });
        }),
      ],
    );
  }

  // Контейнер для веса или возраста
  Widget _buildWeightAgeContainer(String label, IconData removeIcon, IconData addIcon, VoidCallback onRemove, VoidCallback onAdd) {
    return Container(
      width: 155,
      height: 170,
      decoration: BoxDecoration(
        color: Color(0xff1d1e33), // Новый цвет для контейнера веса/возраста
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(fontSize: 20, color: Colors.white)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                color: Colors.white,
                icon: Icon(removeIcon, size: 50),
                onPressed: onRemove,
              ),
              IconButton(
                color: Colors.white,
                icon: Icon(addIcon, size: 50),
                onPressed: onAdd,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Кнопка расчета
  Widget _buildCalculateButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BMIResultScreen(
              height: height,
              weight: weight,
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pink,
        minimumSize: Size(375, 73),
      ),
      child: Text('CALCULATE', style: TextStyle(fontSize:40, color: Colors.white)),
    );
  }
}
class BMIResultScreen extends StatelessWidget {
  final double height;
  final int weight;

  const BMIResultScreen({super.key, required this.height, required this.weight});

  @override
  Widget build(BuildContext context) {
    double bmi = weight / ((height / 100) * (height / 100)); // Расчет BMI

    String result = '';
    if (bmi < 18.5) {
      result = 'Азырак салмак';
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      result = 'Нормалдуу';
    } else if (bmi >= 25 && bmi <= 29.9) {
      result = 'Артык салмак';
    } else {
      result = 'Арыктоо';
    }

    return Scaffold(
      backgroundColor: Color(0xff0a0321), // Новый цвет фона
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ден соолук индекси'),
            SizedBox(width: 10), // Пространство между названием и текстом "I love you"
          ],
        ),
        backgroundColor: Colors.grey,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0), // Отступы от краев контейнера
                child: Text(
                  'Jyiyntyk', 
                  style: TextStyle(fontSize: 50, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height:1 ), // Отступ между результатом и текстом
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                color: Color(0xff1d1e33),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff1d1e33),
                    offset: Offset(5, 5),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      result, // Показываем результат по BMI
                      style: TextStyle(fontSize: 25, color: Colors.green),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      bmi.toStringAsFixed(1), // Показываем значение BMI
                      style: TextStyle(
                          fontSize: 100, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.pink,
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}