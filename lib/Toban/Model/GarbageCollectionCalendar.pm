package Toban::Model::GarbageCollectionCalendar;
use Mouse;
use MouseX::AttributeHelpers;

has 'calendar' => (
    metaclass => 'Collection::Array',
    is        => 'rw',
    isa       => 'ArrayRef',
    default   => sub { [] },
    provides  => {
        push  => 'push_calendar',
        shift => 'shift_calendar',
    },
);

__PACKAGE__->meta->make_immutable();

no Mouse;

use Toban::DB::Mongo;

sub list {
    my $self = shift;

    my $calendar = Toban::Model::GarbageCollectionCalendar->new();
    $calendar->_get_calendar;
    return $calendar->calendar;
}

sub _get_calendar {
    my $self = shift;

    my $mongo = Toban::DB::Mongo->new( collection => 'GarbageCollectionCalendar');
    my $collection = $mongo->get_collection();
    my $calendars = $collection->find;

    while ( my $doc = $calendars->next ) {
        $self->push_calendar({
                start => $doc->{start},
                title => $doc->{title},
                order => $doc->{id},
        });
    }
}


1;
