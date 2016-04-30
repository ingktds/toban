package Toban::Model::Config;
use Mouse;

has 'file' => (
    is      => 'rw',
    isa     => 'Str',
    default => '../../../../toban.json',
);

__PACKAGE__->meta->make_immutable();
no Mouse;

use autodie;
use IO::File;
use JSON::XS;

sub load_config {
    my $self = shift;

    my $file = $self->file;

    my $fh = IO::File->new($file, 'r');
    local $/ = undef;
    my $str = <$fh>;
    $fh->close;

    return $str;
}

sub config {
    my $self = shift;

    my $str = $self->load_config();
    my $code = JSON::XS->new->utf8->decode($str);

    return $code;
}

1;
