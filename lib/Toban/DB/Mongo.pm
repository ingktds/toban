package Toban::DB::Mongo;
use Mouse;

has 'collection' => (
    is  => 'rw',
    isa => 'Str',
);

__PACKAGE__->meta->make_immutable();
no Mouse;

use JSON::XS;
use MongoDB;

sub get_collection {
    my $self = shift;

    # Mojoliciousの設定ファイル読み込み
    my $line = load_config( '/Users/ingktds/repos/toban/toban.json' );
    my $json = JSON::XS->new->ascii->pretty->allow_nonref->utf8;
    my $config = $json->decode( $line );
    
    my $client = MongoDB::MongoClient->new(
        host => $config->{mongo}{host},
        port => $config->{mongo}{port},
    );
    
    my $database = $client->get_database($config->{mongo}{database});
    my $collection = $database->get_collection($self->collection);

    return $collection;
}

sub load_config {
    my $file = shift;
    local $/ = undef;
    open my $fh, '<', $file or die $!;
    my $line = <$fh>;
    return $line;
}

1;
