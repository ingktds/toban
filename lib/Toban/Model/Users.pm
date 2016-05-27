package Toban::Model::Users;
use Mouse;

has 'last_name' => (
    is => 'rw',
    isa => 'Str',
    required => 1,
);

has 'first_name' => (
    is => 'rw',
    isa => 'Str',
    required => 1,
);

has 'email' => (
    is => 'rw',
    isa => 'Str',
    required => 1,
);

has 'password' => (
    is => 'rw',
    isa => 'Str',
    required => 1,
);

__PACKAGE__->meta->make_immutable();
no Mouse;

use Time::Piece;
use Toban::DB::Mongo;
use Crypt::SaltedHash;

sub insert {
    my $self = shift;

    my $last_name = $self->last_name;
    my $first_name = $self->first_name;
    my $email = $self->email;
    my $password = $self->password;
    my $t = localtime;

    my $csh = Crypt::SaltedHash->new(algorithm => 'SHA-512');
    $csh->add( $password );
    my $salted = $csh->generate();

    # 新規登録データの作成
    my $data = {
        last_name  => $last_name,
        first_name => $first_name,
        email      => $email,
        password   => $salted,
        created_at => $t->datetime,
        updated_at => $t->datetime,
    };

    my $db = Toban::DB::Mongo->new(
        collection => 'users'
    );

    my $users = $db->get_collection();
    $users->insert( $data );

    # unique index
    $users->ensure_index({ email => 1 }, { unique => 1 });
}

1;
