package Toban::Controller::Calendar;
use Mojo::Base 'Mojolicious::Controller';

sub index {
    my $c = shift;

    $c->render( 'calendar/index' );
}

1;
