import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mtracker/constant.dart';
import 'package:mtracker/model/transaction.dart';
import 'package:mtracker/services/database_manager.dart';

class AddTransaction extends StatefulWidget {
  static const route = '/add';
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
  DateTime dateTime = DateTime.now();
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextFormField(
                        controller: _atmCtrl,
                        autofocus: true,
                        style: Theme.of(context).textTheme.headline3,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
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
                    DateTimeField(
                      format: DateFormat("dd-MM-yyyy hh:mm aaa"),
                      initialValue: dateTime,
                      decoration: const InputDecoration(
                        hintText: 'Date Time',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return "Please give date and time";
                        }
                        return null;
                      },
                      onChanged: (val) {
                        dateTime = val!;
                      },
                      onShowPicker: (context, currentValue) async {
                        final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now()
                              .subtract(const Duration(days: 365 * 3)),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365 * 3)),
                        );
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now(),
                            ),
                          );
                          return DateTimeField.combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
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
                            // final time = Timestamp.now();
                            final TransactionModel model = TransactionModel(
                              id: id,
                              note: _noteCtrl.text.trim(),
                              amount: widget.transactionType == 'Outgoing'
                                  ? num.parse(_atmCtrl.text) * -1
                                  : num.parse(_atmCtrl.text),
                              type: widget.transactionType,
                              timestamp: Timestamp.fromDate(dateTime),
                              date: formatDate(dateTime),
                              description: _descriptionCtrl.text.trim(),
                              pin: false,
                              searchIndex:
                                  indexGenerator(_noteCtrl.text.trim()),
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
