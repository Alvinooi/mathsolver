// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class ShareDialog extends StatefulWidget {
  const ShareDialog({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<ShareDialog> createState() => _ShareDialogState();
}

class _ShareDialogState extends State<ShareDialog> {
  final TextEditingController _emailController = TextEditingController();
  List<Map<String, dynamic>> _sharedUsers = [];
  String _generalAccess = 'Restricted';
  bool _notifyPeople = true;
  String _message = '';

  void _addUser(String email) {
    if (email.isNotEmpty) {
      setState(() {
        _sharedUsers.add({'email': email, 'role': 'Editor'});
      });
      _emailController.clear();
    }
  }

  void _removeUser(String email) {
    setState(() {
      _sharedUsers.removeWhere((user) => user['email'] == email);
    });
  }

  void _updateRole(String email, String role) {
    setState(() {
      final userIndex =
          _sharedUsers.indexWhere((user) => user['email'] == email);
      if (userIndex != -1) {
        _sharedUsers[userIndex]['role'] = role;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: widget.width ?? 400,
        height: widget.height ?? 600,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Share File',
              style: FlutterFlowTheme.of(context).titleMedium,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Add people, groups, or emails',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _addUser(_emailController.text),
                ),
              ),
              onSubmitted: _addUser,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _sharedUsers.length,
                itemBuilder: (context, index) {
                  final user = _sharedUsers[index];
                  return ListTile(
                    title: Text(user['email']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButton<String>(
                          value: user['role'],
                          items: ['Viewer', 'Editor', 'Commenter']
                              .map((role) => DropdownMenuItem(
                                    value: role,
                                    child: Text(role),
                                  ))
                              .toList(),
                          onChanged: (value) =>
                              _updateRole(user['email'], value ?? 'Editor'),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => _removeUser(user['email']),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Divider(),
            ListTile(
              leading: Icon(Icons.link),
              title: Text('General access'),
              subtitle: Text(_generalAccess),
              trailing: DropdownButton<String>(
                value: _generalAccess,
                items: ['Restricted', 'Anyone with the link']
                    .map((access) => DropdownMenuItem(
                          value: access,
                          child: Text(access),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _generalAccess = value ?? 'Restricted';
                  });
                },
              ),
            ),
            Divider(),
            Row(
              children: [
                Checkbox(
                  value: _notifyPeople,
                  onChanged: (value) {
                    setState(() {
                      _notifyPeople = value ?? true;
                    });
                  },
                ),
                const SizedBox(width: 8),
                Text('Notify people'),
              ],
            ),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Add a message (optional)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _message = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle sharing logic
                    print('Shared Users: $_sharedUsers');
                    print('General Access: $_generalAccess');
                    print('Notify People: $_notifyPeople');
                    print('Message: $_message');
                    Navigator.of(context).pop();
                  },
                  child: Text('Share'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
