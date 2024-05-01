import '../const/consts.dart';

class AddAnnouncementPage extends StatefulWidget {
  @override
  _AddAnnouncementPageState createState() => _AddAnnouncementPageState();
}

class _AddAnnouncementPageState extends State<AddAnnouncementPage> {
  final _formKey = GlobalKey<FormState>();
  String? _title, _content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Announcement'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
              onSaved: (value) => _title = value,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Content'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a content';
                }
                return null;
              },
              onSaved: (value) => _content = value,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Add Announcement'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Add announcement to database
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
