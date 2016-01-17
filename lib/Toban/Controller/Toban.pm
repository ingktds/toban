package Toban::Controller::Toban;
use Mojo::Base 'Mojolicious::Controller';
use Mojo::JSON;
use Toban::Model::Member;

sub list {
    my $c = shift;
    my $member = Toban::Model::Member->member_list;
    $c->render(json => $member);
    
}

1;
