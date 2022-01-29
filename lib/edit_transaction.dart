import 'package:flutter/material.dart';

import 'model/transaction.dart';
import 'services/database_manager.dart';

class EditTransaction extends StatefulWidget {
  final TransactionModel transactionModel;

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
                    TextFormField(
                      controller: _atmCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Amount',
                        border: InputBorder.none,
                      ),
                      autofocus: true,
                      style: Theme.of(context).textTheme.headline5,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter transaction amount';
                        }
                        try {
                          num.parse(value);
                        } catch (e) {
                          return 'Please enter valid amount';
                        }
                      },
                    ),
                    const Divider(),
                    TextFormField(
                      controller: _noteCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Note',
                        border: InputBorder.none,
                      ),
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter transaction note';
                        }
                        if (value.length > 10) {
                          return 'Transaction note should ne less than 10 words';
                        }
                      },
                    ),
                    const Divider(),
                    TextFormField(
                      controller: _descriptionCtrl,
                      decoration: const InputDecoration(
                        hintText: 'description',
                        border: InputBorder.none,
                      ),
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter transaction description';
                        }
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
