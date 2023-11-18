

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medify/view/model/model_event.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:calendar_view/calendar_view.dart';
class EventDayView extends StatefulWidget {
  final DateTime fechaSeleccionada;
  
  

  EventDayView({required this.fechaSeleccionada});

  @override
  State<EventDayView> createState() => _EventDayViewState();
}

class _EventDayViewState extends State<EventDayView> {



  
  @override
  Widget build(BuildContext context) {

    var eventController = EventController();
    // Create an event instance
final myEvent = CalendarEventData(
   date: DateTime(2023, 11, 15),
    event: "Event 1",
    title: 'mi evento'
  // Add other event details
);

// Add the event to the controller
eventController.add(myEvent as CalendarEventData<Object?>);


  print(widget.fechaSeleccionada);
    return Scaffold(
      backgroundColor: Colors.black, // Fondo oscuro
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.add, size: 40,color: Colors.blue,))],
        centerTitle: true,
        // leading: Icon(Icons.arrow_back, color: Colors.white), // Icono de retroceso blanco
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: widget.fechaSeleccionada,
            calendarFormat: CalendarFormat.week,
            // selectedDayPredicate: (day) => isSameDay(widget.fechaSeleccionada, day),
            currentDay: widget.fechaSeleccionada,
          
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
             
              
              outsideDaysVisible: false,
            ),
            headerVisible: false,
          ),

          Flexible(
            child: CalendarControllerProvider(
              controller: EventController(),
              child: DayView(
                dayTitleBuilder: (date) => Text(date.toString()),
                backgroundColor: Colors.black,
                controller: eventController,
                eventTileBuilder: (date, events, boundry, start, end) {
                    // Return your widget to display as event tile.
                    print(events);
                    print(date);
                    return Text('hplaaaa',style: TextStyle(color: Colors.white),);
                },
                fullDayEventBuilder: (events, date) {
                    // Return your widget to display full day event view.
                    return Container();
                },
                showVerticalLine: true, // To display live time line in day view.
                showLiveTimeLineInAllDays: true, // To display live time line in all pages in day view.
                minDay: DateTime(1990),
                maxDay: DateTime(2050),
                initialDay: widget.fechaSeleccionada,
                heightPerMinute: 1, // height occupied by 1 minute time span.
                eventArranger: SideEventArranger(), // To define how simultaneous events will be arranged.
                onEventTap: (events, date) => print(events),
                onDateLongPress: (date) => print(date),
                      ),
            ),
          ),
          

                      // Aquí puedes agregar otros widgets, como un ícono o un texto para mostrar eventos
                    ],
                  ),
                );
              }
            
  }

