import 'package:add_2_calendar/add_2_calendar.dart' as add_2_calendar;
import 'package:social_app_2/src/features/events/domain/event.dart';

class CalendarService {
  void addToCalendar({required Event appEvent}) {
    final add_2_calendar.Event calendarEvent = add_2_calendar.Event(
      title: appEvent.title,
      description: appEvent.eventDetails,
      location:
          '${appEvent.location}, ${appEvent.address}, ${appEvent.city}, ${appEvent.state}, ${appEvent.zip}',
      startDate: appEvent.startDate,
      endDate: appEvent.endDate,

      allDay: false, // Set to true if the event is all day
    );
    add_2_calendar.Add2Calendar.addEvent2Cal(calendarEvent);
  }
}
