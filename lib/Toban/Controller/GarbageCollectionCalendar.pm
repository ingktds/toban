package Toban::Controller::GarbageCollectionCalendar;
use Mojo::Base 'Mojolicious::Controller';
use Mojo::JSON;
use Toban::Model::GarbageCollectionCalendar;

sub list {
    my $c = shift;

    my $calendar = Toban::Model::GarbageCollectionCalendar->list();

    $c->render( json => $calendar );
}

1;
