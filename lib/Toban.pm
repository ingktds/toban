package Toban;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Config
  my $config = $self->plugin( 'JSONConfig' );

  # Router
  my $r = $self->routes;

  # Root
  $r->get( '/' )->to( 'root#index' );

  # API
  $r->get( '/v1/calendar' )->to( 'garbage_collection_calendar#list' );
  $r->get( '/v1/assignment' )->to( 'toban#list' );

  # preflight requestを受け入れるためOPTIONSが要る
  $r->any( ['OPTIONS', 'PUT'] => '/v1/assignment' )->to( 'toban#update' );

  # Authentication
  $r->post( '/login' )->to( 'login#authenticate' );

  # Calendar
  $r->get( '/calendar' )->to( 'calendar#index' );

  # Registration
  $r->post( '/create' )->to( 'users#insert' );
}

1;
