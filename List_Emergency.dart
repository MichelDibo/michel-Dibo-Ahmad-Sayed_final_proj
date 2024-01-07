class List_Emergency {
  String Name;
  int Number; // Change the type to String
  String Description;
  String Image;

  List_Emergency(this.Name, this.Number, this.Description, this.Image);

  @override
  String toString() {
    return "$Name ";
  }
}

List<List_Emergency> data = [];
