use strict;
package SequenceWord;

sub new{
	my $class = shift;
	my $self = {
		_sequence => shift,
		_word => shift,
		_count => undef,
	};
	bless $self, $class;
	$self->{_count} = 1;
	#print "Sequence is $self->{_sequence}\n";
	#print "_word is $self->{_word}\n";
		
	return $self;
}

sub sequence {
	my ($self, $sequence) = @_;
	$self->{_sequence} = $sequence if defined($sequence);
	return $self->{_sequence};
}

sub word {
	my ($self, $word) = @_;
	$self->{_word} = $word if defined($word);
	return $self->{_word};
}

sub getCount {
	my ($self) = @_;
	return $self->{_count};
}

sub incrementCount {
	my ($self) = @_;
	$self->{_count}++;
	return $self->{_count};
}

1;