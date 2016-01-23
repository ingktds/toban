package Toban;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  # Router
  my $r = $self->routes;

  # Normal route to controller
  #$r->get('/')->to('toban#list');

  # API
  #$r->get('/v1/members')->to('toban#list');
  $r->get('/v1/calendar')->to('garbage_collection_calendar#list');

}

1;
