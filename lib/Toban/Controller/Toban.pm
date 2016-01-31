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

sub update {
    my $c = shift;

    my $calendar = Toban::Model::Toban->list;
    $calendar->update({
        start => $c->param('date');
        title => $c->param('member');
    });
}

1;
