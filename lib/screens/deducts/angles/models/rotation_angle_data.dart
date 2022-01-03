import 'dart:math';

class RotationAngleData {
  final double water, deep, barSize;

  RotationAngleData(this.water, this.deep, this.barSize);

  double waterWithBar() => water + (barSize * 2);
  double deepWithBar() => deep + barSize / 2;

  radius() {
    double up = (pow(water, 2) + (4 * (pow(deep, 2)))).toDouble();
    print(barSize);

    double down = 8 * deep;
    double data = up / down;
    return data;
  }

  radiusWithBar() {
    double up =
        (pow(waterWithBar(), 2) + (4 * (pow(deepWithBar(), 2)))).toDouble();
    print(barSize);
    double down = 8 * deepWithBar();
    double data = up / down;
    return data;
  }

  cutAngle() {
    double needData = (radius() - deep) / radius();
    double up = asin(needData);
    double rad = (up * 180) / pi;
    double data = rad / 2;
    return data;
  }

  cutAngleWithBar() {
    double needData = (radiusWithBar() - deepWithBar()) / radiusWithBar();
    double up = asin(needData);
    double rad = (up * 180) / pi;
    double data = rad / 2;
    return data;
  }

  archAngle() {
    double needData = (water) / (2 * radius());
    double rad = asin(needData);
    double data = 2 * ((rad * 180) / pi);
    return data;
  }

  archAngleWithBar() {
    double needData = waterWithBar() / (2 * radiusWithBar());
    double rad = asin(needData);
    double data = 2 * ((rad * 180) / pi);
    return data;
  }

  archSize() {
    double data = (radius() * archAngle()) / 57.3;
    return data;
  }

  archSizeWithBar() {
    double data = (radiusWithBar() * archAngleWithBar()) / 57.3;
    return data;
  }
}
