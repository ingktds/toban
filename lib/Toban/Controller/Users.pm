package Toban::Controller::Users;
use Mojo::Base 'Mojolicious::Controller';
use Toban::Model::Users;

sub index {
    my $c = shift;

    $c->render( template => 'create' );
}

sub insert {
    my $c = shift;
    my $users = Toban::Model::Users->new(
        last_name  => $c->param('last_name'),
        first_name => $c->param('first_name'),
        email      => $c->param('email'),
        password   => $c->param('password'),
    );

    $users->insert;

    $c->redirect_to( '/login' );
}

1;
