package Toban::Controller::Toban;
use Mojo::Base 'Mojolicious::Controller';
use Toban::Model::Toban;

sub list {
    my $c = shift;

    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    my $member = Toban::Model::Toban->list;

    $c->render(json => $member);
    
}

sub update {
    my $c = shift;

    $c->res->headers->header( 'Access-Control-Allow-Origin' => 'http://' . $c->app->config->{mojo}{host}{www} );
    $c->res->headers->header( 'Access-Control-Allow-Credentials' => 'true' );
    $c->res->headers->header( 'Access-Control-Allow-Methods' => 'PUT, OPTIONS' );
    $c->res->headers->header( 'Access-Control-Allow-Headers' => 'Accept, Content-Type' );
    $c->res->headers->header( 'Access-Control-Max-Age' => '3600' );

    my $calendar = Toban::Model::Toban->init;
    $calendar->update({
        start => $c->param('date'),
        title => $c->param('member'),
        id => $c->param('id'),
    });

    $c->render(json => $calendar);
}

1;
