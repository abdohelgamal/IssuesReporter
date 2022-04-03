///A model for Issues to use them as objects
class Issue {
  final int id;
  final String title;
  final String picturePath;
  final String description;
  final String date;
  final String status;
  final String? longitude;
  final String? latitude;

  Issue(this.id, this.title, this.picturePath, this.description, this.date,
      this.status, this.latitude, this.longitude);

  ///This facory method returns an object of an [Issue] with the given data in the [Map]
  factory Issue.fromMap(Map map) {
    return Issue(
        map['id'],
        map['title'],
        map['picturePath'],
        map['description'],
        map['date'],
        map['status'],
        map['latitude'] == " " ? null : map['latitude'],
        map['longitude'] == " " ? null : map['longitude']);
  }

  ///This method returns the data of the [Issue] as a [Map] but with no ID property
  Map<String, Object> toMap() {
    return {
      'date': date,
      'picturePath': picturePath,
      'title': title,
      'description': description,
      'status': status,
      'longitude': longitude == null ? " " : longitude!,
      'latitude': latitude == null ? " " : latitude!,
    };
  }

  ///This method returns the data of the [Issue] as a [Map]
  Map<String, Object> toMapWithID() {
    return {
      'id': id,
      'date': date,
      'picturePath': picturePath,
      'title': title,
      'description': description,
      'status': status,
      'longitude': longitude == null ? " " : longitude!,
      'latitude': latitude == null ? " " : latitude!,
    };
  }
}
