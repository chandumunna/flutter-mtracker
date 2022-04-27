import 'package:flutter/material.dart';
import 'package:mtracker/constant.dart';
import 'package:mtracker/model/transaction.dart';
import 'package:mtracker/services/database_manager.dart';

class EditTransaction extends StatefulWidget {
  final TransactionModel transactionModel;
  static const route = '/edit';
  const EditTransaction({
    Key? key,
    required this.transactionModel,
  }) : super(key: key);

  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _atmCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();

  @override
  void initState() {
    final num atm = widget.transactionModel.amount.isNegative
        ? widget.transactionModel.amount * -1
        : widget.transactionModel.amount;
    _atmCtrl.text = atm.toString();
    _noteCtrl.text = widget.transactionModel.note;
    _descriptionCtrl.text = widget.transactionModel.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Delete confirmation'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Are sure want to delete this transaction',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    '${widget.transactionModel.note} at ${widget.transactionModel.date} : \n ${formatAtm(widget.transactionModel.amount)}',
                  )
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    DatabaseManager.deleteTransaction(
                      widget.transactionModel,
                    ).then((value) => Navigator.pop(context));
                  },
                  child: const Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ).then(
            (value) => Navigator.pop(context),
          );
        },
        child: const Icon(Icons.delete),
      ),
      appBar: AppBar(
        title: const Text('Add Transaction'),
      ),
      body: Form(
        key: _formKey,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextFormField(
                        controller: _atmCtrl,
                        autofocus: true,
                        style: Theme.of(context).textTheme.headline3,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Amount',
                          hintStyle: Theme.of(context).textTheme.headline3,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          filled: true,
                          contentPadding: const EdgeInsets.all(16),
                          fillColor: Colors.grey.shade200,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter transaction amount';
                          }
                          try {
                            num.parse(value);
                          } catch (e) {
                            return 'Please enter valid amount';
                          }
                          return null;
                        },
                      ),
                    ),
                    const Divider(),
                    TextFormField(
                      controller: _noteCtrl,
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'Note',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter transaction note';
                        }
                        if (value.length > 10) {
                          return 'Transaction note should ne less than 10 words';
                        }
                        return null;
                      },
                    ),
                    const Divider(),
                    TextFormField(
                      controller: _descriptionCtrl,
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.newline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter transaction description';
                        }
                        return null;
                      },
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            final TransactionModel model = TransactionModel(
                              id: widget.transactionModel.id,
                              note: _noteCtrl.text.trim(),
                              amount: widget.transactionModel.type == 'Outgoing'
                                  ? num.parse(_atmCtrl.text) * -1
                                  : num.parse(_atmCtrl.text),
                              type: widget.transactionModel.type,
                              timestamp: widget.transactionModel.timestamp,
                              date: widget.transactionModel.date,
                              description: _descriptionCtrl.text.trim(),
                              pin: widget.transactionModel.pin,
                            );
                            DatabaseManager.addTransaction(model)
                                .then((value) => Navigator.pop(context));
                          }
                        },
                        icon: const Icon(
                          Icons.save,
                          size: 30,
                        ),
                        label: Text(
                          'Save',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
