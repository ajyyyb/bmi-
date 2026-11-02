# BMI calculator

A body mass index calculator in Flutter with a dark interface.

## How it works

- Choose MALE or FEMALE.
- Set the height with a slider (in cm).
- Set the weight (not below 30 kg) and the age (not below 10) with the plus and minus buttons.
- Press CALCULATE to open the result screen.
- The index is `weight / (height in meters)²`. The result screen shows it with a short text for the group: below 18.5, 18.5 to 24.9, 25 to 29.9, and 30 and above.

The result screen is in Kyrgyz.

## Run it

```bash
flutter pub get
flutter run
```
