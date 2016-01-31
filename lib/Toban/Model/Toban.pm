package Toban::Model::Toban;
use Mouse;
use MouseX::AttributeHelpers;

has 'toban' => (
    metaclass => 'Collection::Array',
    is        => 'rw',
    isa       => 'ArrayRef',
    default   => sub { [] },
    provides  => {
        push  => 'push_toban',
        shift => 'shift_toban',
    },
);

__PACKAGE__->meta->make_immutable();

no Mouse;

use Toban::DB::Mongo;

sub list {
    my $self = shift;

    my $toban = __PACKAGE__->new();
    $toban->_get_calendar;
    return $toban->toban;
}

sub _get_calendar {
    my $self = shift;

    my $mongo = Toban::DB::Mongo->new( collection => 'Toban');
    my $collection = $mongo->get_collection();
    my $calendars = $collection->find;

    while ( my $doc = $calendars->next ) {
        $self->push_toban({
                start => $doc->{start},
                title => $doc->{title},
                order => $doc->{id},
        });
    }
}

sub update {
    my ( $self, $args ) = @_;
    my $start = $args->{start};
    my $title = $args->{title};

    my $mongo = Toban::DB::Mongo->new( collection => 'Toban');
    my $collection = $mongo->get_collection();
    my $calendars = $collection->find;

    $calendars->update_one({
        { "start" => $start },
        { '$set' =>
            {
                "title" => $title,
            }
        }
    });
}

1;
