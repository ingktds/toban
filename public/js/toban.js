$(document).ready(function() {
  $('#calendar').fullCalendar({
    firstDay: 1,
    eventSources: [
      {
        url: 'http://api.toban.ingk.xyz/v1/assignment',
        editable: true
      },
      {
        url: 'http://api.toban.ingk.xyz/v1/calendar',
        color: '#3CB371',
        editable: false
      }
    ],
    eventOrder: 'order',
    eventDrop: function(event) {
        $.ajax({
            type: 'PUT',
            url: 'http://api.toban.ingk.xyz/v1/assignment',
            crossDamain: true,
            data: {
                member: event.title,
                date: "2016-02-03"
            }
        });
    }
  })

}); 
