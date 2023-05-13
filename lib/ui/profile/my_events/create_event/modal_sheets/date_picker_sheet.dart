import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:uni_connect/ui/profile/my_events/create_event/create_event_view_model.dart';
import 'package:uni_connect/ui/theme/app_colors.dart';

class DatePickerSheet extends StatelessWidget {
  final BuildContext createContext;
  const DatePickerSheet({Key? key, required this.createContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = createContext.read<CreateEventViewModel>();
    final pickedDate = model.pickedDate;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 24,),
              const Text('Pick a date of event', style: TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500
              ),),
              GestureDetector(
                onTap: Navigator.of(context).pop,
                child: const Icon(Icons.close)
              )
            ],
          ),
          const SizedBox(height: 20,),
          SfDateRangePicker(
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) => model.changePickedDate(args.value),
            enablePastDates: false,
            showNavigationArrow: true,
            selectionMode: DateRangePickerSelectionMode.single,
            selectionColor: AppColors.mainColor,
            initialSelectedDate: pickedDate,
          ),
          const SizedBox(height: 40,),
        ],
      ),
    );
  }
}
