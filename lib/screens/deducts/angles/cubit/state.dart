abstract class CornerState {}

class InitState extends CornerState {}

class AddNewCorner extends CornerState {}

class ClearLists extends CornerState {}

class ClearCornerAngle extends CornerState {}

class AddNewCornerBackAngle extends CornerState {}

class AddNewRotateAngle extends CornerState {}

class BarSizeChange extends CornerState {}

class AddNewIrregularAngle extends CornerState {}

class CornerSizesChange extends CornerState {}

class CornerBackAngleChange extends CornerState {}

class IrregularAngleChange extends CornerState {}

class RotationChange extends CornerState {}

class ShowResultChanged extends CornerState {}

class ShowAngleChanged extends CornerState {}

class WithBarChanged extends CornerState {}
