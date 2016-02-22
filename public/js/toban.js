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
        //console.dir(event);

        // Drop先の日付を取得
        var drop_date = $.fullCalendar.moment(event._start._d);
        var date = drop_date.format('YYYY-MM-DD');

        $.ajax({
            type: 'PUT',
            url: 'http://api.toban.ingk.xyz/v1/assignment',
            crossDamain: true,
            dataType: 'json',
            data: {
                member: event.title,
                date: date,
                id: event.order
            }
        });

    }
  })

}); 
