import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mtracker/constant.dart';
import 'package:mtracker/model/transaction.dart';
import 'package:mtracker/services/database_manager.dart';

class AddTransaction extends StatefulWidget {
  final String transactionType;
  final List<String> chips;

  const AddTransaction({
    Key? key,
    required this.transactionType,
    required this.chips,
  }) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _atmCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();

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
                        return null;
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
                        return null;
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
                        return null;
                      },
                    ),
                    const Divider(),
                    Wrap(
                      children: List.generate(
                        widget.chips.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _noteCtrl.text = widget.chips[index];
                                _descriptionCtrl.text = widget.chips[index];
                              });
                            },
                            child: Chip(
                              label: Text(widget.chips[index]),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            final String id =
                                '${DateTime.now().microsecondsSinceEpoch}';
                            final time = Timestamp.now();
                            final TransactionModel model = TransactionModel(
                              id: id,
                              note: _noteCtrl.text.trim(),
                              amount: widget.transactionType == 'Outgoing'
                                  ? num.parse(_atmCtrl.text) * -1
                                  : num.parse(_atmCtrl.text),
                              type: widget.transactionType,
                              timestamp: time,
                              date: formatDate(time.toDate()),
                              description: _descriptionCtrl.text.trim(),
                              pin: false,
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
