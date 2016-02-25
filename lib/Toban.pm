package Toban;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Config
  my $config = $self->plugin( 'JSONConfig' );

  # Router
  my $r = $self->routes;

  # API
  $r->get( '/v1/calendar' )->to( 'garbage_collection_calendar#list' );
  $r->get( '/v1/assignment' )->to( 'toban#list' );

  # preflight requestを受け入れるためOPTIONSが要る
  $r->any( ['OPTIONS', 'PUT'] => '/v1/assignment' )->to( 'toban#update' );

  # Authentication
  $r->get( '/login' )->to( 'login#index' );
  $r->post( '/login' )->to( 'login#authenticate' );
}

1;
