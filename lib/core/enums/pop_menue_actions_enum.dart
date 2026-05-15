enum PopMenueActionsEnum {
  done(name: ' Done / Undone'),
  edit(name: 'Edit'),
  delete(name: 'Delete');

  final String name;

  const PopMenueActionsEnum({required this.name});
}
