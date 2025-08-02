import 'package:agenda_wizard/ui/core/widgets/form_input.dart';
import 'package:flutter/material.dart';

class DeleteIcon extends StatelessWidget {
  const DeleteIcon(
      {super.key, required this.deleteCallback, required this.agendaPart});

  final Function deleteCallback;
  final String agendaPart;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                title:
                    Text('Are you sure you want to delete this $agendaPart?'),
                children: <Widget>[
                  SimpleDialogOption(
                    onPressed: () {
                      deleteCallback();
                      Navigator.pop(context);
                    },
                    child: const Text('Yes'),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No'),
                  ),
                ],
              );
            }),
        icon: const Icon(Icons.delete));
  }
}

class AddAgendaPart extends StatefulWidget {
  const AddAgendaPart(
      {super.key,
      required this.addCallback,
      required this.agendaPart,
      required this.titleLabel,
      required this.contentLabel});

  final Function addCallback;
  final String agendaPart;
  final String titleLabel;
  final String contentLabel;

  @override
  State<AddAgendaPart> createState() => _AddAgendaPartState();
}

class _AddAgendaPartState extends State<AddAgendaPart> {
  bool addingItem = false;

  final TextEditingController itemTitle = TextEditingController();
  final TextEditingController itemContent = TextEditingController();

  @override
  void dispose() {
    itemTitle.dispose();
    itemContent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!addingItem) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton.icon(
              label: Text('Add ${widget.agendaPart}'),
              onPressed: () => {
                    setState(() {
                      addingItem = true;
                    })
                  },
              icon: const Icon(Icons.add)),
        ],
      );
    } else {
      return Form(
          key: GlobalKey<FormState>(),
          child: Column(
            children: [
              FormInput(
                labelText: widget.titleLabel,
                fieldController: itemTitle,
                isRequired: true,
              ),
              FormInput(
                labelText: widget.contentLabel,
                fieldController: itemContent,
                isRequired: false,
                inputType: TextInputType.multiline,
                maxLines: null,
                minLines: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                      label: const Text('Cancel'),
                      onPressed: () => {
                            setState(() {
                              itemTitle.text = "";
                              itemContent.text = "";
                              addingItem = false;
                            })
                          },
                      icon: const Icon(Icons.cancel)),
                  TextButton.icon(
                      label: Text('Save ${widget.agendaPart}'),
                      onPressed: () => {
                            setState(() {
                              widget.addCallback(
                                  itemTitle.text, itemContent.text);
                              addingItem = false;
                              itemTitle.text = "";
                              itemContent.text = "";
                            })
                          },
                      icon: const Icon(Icons.save)),
                ],
              ),
            ],
          ));
    }
  }
}
