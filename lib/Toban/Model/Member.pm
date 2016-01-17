package Toban::Model::Member;
use Mouse;
use MouseX::AttributeHelpers;

has 'member' => (
    metaclass => 'Collection::Array',
    is        => 'rw',
    isa       => 'ArrayRef',
    default   => sub { [] },
    provides  => {
        set  => 'set_member',
        get  => 'get_member',
        push => 'push_member',
    },
);

__PACKAGE__->meta->make_immutable();
no Mouse;

use Toban::DB::Mongo;

sub member_list {
    my $self = shift;

    my $member = Toban::Model::Member->new();
    $member->_get_member;
    return $member->member;
}

sub _get_member {
    my $self = shift;

    my $mongo = Toban::DB::Mongo->new( collection => 'member');
    my $collection = $mongo->get_collection();
    my $members = $collection->find;

    while ( my $doc = $members->next ) {
        $self->push_member( $doc->{name} );
    }
}

1;
