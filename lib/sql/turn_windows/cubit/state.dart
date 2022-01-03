abstract class SQLTurnState {}

class InitState extends SQLTurnState {}

class CreateDb extends SQLTurnState {}

class InsertDataToDb extends SQLTurnState {}

class GetDataFromDb extends SQLTurnState {}

class DeleteDataFromDb extends SQLTurnState {}

class UpdateData extends SQLTurnState {}

class SystemNameChange extends SQLTurnState {}

class ValidateIncState extends SQLTurnState {}

class IsPVCState extends SQLTurnState {}

class SashOnChangeState extends SQLTurnState {}

class FlyScreenOnChangeState extends SQLTurnState {}

class OtherOnChangeState extends SQLTurnState {}

class GlassOnChangeState extends SQLTurnState {}

class WeightOnChangeState extends SQLTurnState {}

class EditDeductState extends SQLTurnState {}
