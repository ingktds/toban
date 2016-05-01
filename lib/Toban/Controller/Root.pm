package Toban::Controller::Root;
use Mojo::Base 'Mojolicious::Controller';

sub index {
    my $c = shift;

    $c->redirect_to( '/login.html' );
}

1;
