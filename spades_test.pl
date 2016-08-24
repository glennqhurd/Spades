#!/usr/bin/perl
use strict;
use warnings;

my @names;
my @bids;
my $player_bids1;
my $player_bids2;
my $player_bids3;
my $player_bids4;
my %deck;
my @suits = qw(D C H S);

@ARGV == 1 or die "Only accepts 1 file input.\n";

open( my $file, $ARGV[0]);

my $line = <$file>;

my @player_names = split ' ', $line;

my @first_spades_move;
my $spades_broken = 0;

while (<>) {
  next if $. == 1;
  my $_ =~ /^\s*\d+\s+(\S+)\s+\d+\s+(\S+)\s+\d+\s+(\S+)\s+\d+\s+(\S+)\s*$/;
  my $column_count = 1;
  if (($_ =~ /^[0-9]+$/) and ($column_count % 2 == 0)){
    foreach my $suit (@suits) {
      my $composite;
      foreach my $card_number (2..10){
        $composite = $card_number.$suit;
        $deck{$composite} = $card_number;
      }
      $composite = "A".$suit;
      $deck{$composite} = 14;

      $composite = "K".$suit;
      $deck{$composite} = 13;

      $composite = "Q".$suit;
      $deck{$composite} = 12;

      $composite = "J".$suit;
      $deck{$composite} = 11;
    }

    push(@bids, $_);
    if ($1 =~ /^[0-9]+$/){
      $player_bids1 += $1;
    }
    if ($2 =~ /^[0-9]+$/){
      $player_bids2 += $2;
    }
    if ($3 =~ /^[0-9]+$/){
      $player_bids3 += $3;
    }
    if ($4 =~ /^[0-9]+$/){
      $player_bids4 += $4;
    }
  }
  elsif (($column_count % 2 == 0) and ($_ ne "--")){
    delete $deck{$_};
    if (($spades_broken == 0) and ($_ =~ /S/)){
      $spades_broken = 1;
    }
  }
  $column_count += 1;
}

print "Player 1:".$player_bids1."\n";
print "Player 2:".$player_bids2."\n";
print "Player 3:".$player_bids3."\n";
print "Player 4:".$player_bids4."\n";

