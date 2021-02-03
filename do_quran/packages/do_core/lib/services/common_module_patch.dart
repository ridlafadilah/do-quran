abstract class CommonModulePatch {
  CommonModulePatch({this.description});
  final String description;

  Future<bool> doCheck();
  Future<dynamic> doProcess();
}
