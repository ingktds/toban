package Toban::DB::Mongo;
use Mouse;

has 'collection' => (
    is  => 'rw',
    isa => 'Str',
);

__PACKAGE__->meta->make_immutable();
no Mouse;

use MongoDB;
use Mojolicious;
use Mojolicious::Plugin::JSONConfig;

sub get_collection {
    my $self = shift;

    # Mojoliciousの設定ファイル読み込み
    my $config = Mojolicious::Plugin::JSONConfig->register(
        Mojolicious->new, {file => '../../../toban.json'}
    );
    
    my $client = MongoDB::MongoClient->new(
        host => $config->{mongo}{host},
        port => $config->{mongo}{port},
    );
    
    my $database = $client->get_database($config->{mongo}{database});
    my $collection = $database->get_collection($self->collection);

    return $collection;
}

1;
