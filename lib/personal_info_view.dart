import 'package:bank_jago_test/custom_widget.dart';
import 'package:flutter/material.dart';

class PersonalInfoView extends StatefulWidget {
  final Function(bool isPossibleNext) canNext;

  const PersonalInfoView({Key key, this.canNext}) : super(key: key);

  @override
  _PersonalInfoViewState createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends State<PersonalInfoView> {
  final formKey = GlobalKey<FormState>();

  final List<String> goalActivation = ["Saving", "Investment", "Retirement", "Future Plan"];
  final List<String> monthlyIncome = [
    "Below Rp 5.000.000,00",
    "Rp 5.000.000,00 - Rp 10.000.000,00",
    "Rp 10.000.000,00 - Rp 50.000.000,00",
    "More than Rp 50.000.000,00",
  ];
  final List<String> monthlyExpense = ["Below Rp 5.000.000,00", "Below Rp 10.000.000,00", "Below Rp 50.000.000,00"];
  String goalActivationSelected;
  String monthlyIncomeSelected;
  String monthlyExpenseSelected;

  bool isNextButtonDisabled() {
    if (goalActivationSelected != null && monthlyIncomeSelected != null && monthlyExpenseSelected != null) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Personal Information",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Please fill in the information below and your goal for digital saving",
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomTextFormFieldDataPicker(
                  // focusNode: subcategoryFocusNode,
                  key: UniqueKey(),
                  maxLines: 5,
                  minLines: 1,
                  titleDialogText: "Choose Option",
                  confirmText: "Confirm",
                  cancelText: "Cancel",
                  defaultTextFieldData: goalActivationSelected ?? "- Choose Option -",
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.grey,
                  ),
                  labelText: "Goal for Activation",
                  dataSelector: goalActivation,
                  onUpdateData: (selectedData) {
                    print(selectedData);
                    setState(() {
                      goalActivationSelected = selectedData;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomTextFormFieldDataPicker(
                  // focusNode: subcategoryFocusNode,
                  key: UniqueKey(),
                  maxLines: 5,
                  minLines: 1,
                  titleDialogText: "Choose Option",
                  confirmText: "Confirm",
                  cancelText: "Cancel",
                  defaultTextFieldData: monthlyIncomeSelected ?? "- Choose Option -",
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.grey,
                  ),
                  labelText: "Monthly Income",
                  dataSelector: monthlyIncome,
                  onUpdateData: (selectedData) {
                    print(selectedData);
                    setState(() {
                      monthlyIncomeSelected = selectedData;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomTextFormFieldDataPicker(
                  // focusNode: subcategoryFocusNode,
                  key: UniqueKey(),
                  maxLines: 5,
                  minLines: 1,
                  titleDialogText: "Choose Option",
                  confirmText: "Confirm",
                  cancelText: "Cancel",
                  defaultTextFieldData: monthlyExpenseSelected ?? "- Choose Option -",
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.grey,
                  ),
                  labelText: "Monthly Expense",
                  dataSelector: monthlyExpense,
                  onUpdateData: (selectedData) {
                    print(selectedData);
                    setState(() {
                      monthlyExpenseSelected = selectedData;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            height: 56,
            width: double.infinity,
            child: MaterialButton(
              elevation: 0.0,
              onPressed: isNextButtonDisabled != null && isNextButtonDisabled()
                  ? () {
                      print("next");
                      widget.canNext(true);
                    }
                  : null,
              color: Colors.white,
              disabledColor: Colors.white60,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Text("Next"),
            )),
      ),
    );
  }
}
