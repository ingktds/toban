package Toban::Controller::Toban;
use Mojo::Base 'Mojolicious::Controller';
use Mojo::JSON;
use Toban::Model::Toban;

sub list {
    my $c = shift;

    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    my $member = Toban::Model::Toban->list;

    $c->render(json => $member);
    
}

1;
