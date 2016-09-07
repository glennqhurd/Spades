#!/usr/bin/perl
use strict;
use warnings;

our (@suits, %deck, $composite, $suit, $card_number);
our ($spades_broken);

@suits = qw(D C H S);
$spades_broken = 0;

my @names;
my @bids;
my $player_bids1;
my $player_bids2;
my $player_bids3;
my $player_bids4;
my $var1;
my $var2;
my $var3;
my $var4;

sub create_deck {
  if (($var1 =~ /^\d+$/)|($var2 =~ /^\d+$/)|($var3 =~ /^\d+$/)|($var4 =~ /^\d+$/)) {
    foreach $suit (@suits) {
      foreach $card_number (2..10){
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
  }
}

sub tally_bids {
  if ($var1 =~ /^\d+$/) {
    $player_bids1 += $var1;
  }
  if ($var2 =~ /^\d+$/) {
    $player_bids2 += $var2;
  }
  if ($var3 =~ /^\d+$/) {
    $player_bids3 += $var3;
  }
  if ($var4 =~ /^\d+$/) {
    $player_bids4 += $var4;
  }
}

sub is_broken {
  if ($var1 =~ /^\d+$/) {
    $spades_broken = 0;
  }
  elsif ($var1 ne "--"){
    delete $deck{$_};
    if (($spades_broken == 0) and ($_ =~ /S/)){
      $spades_broken = 1;
    }
  } 
  if ($var2 =~ /^\d+$/) {
    $spades_broken = 0;
  }
  elsif ($var2 ne "--"){
    delete $deck{$_};
    if (($spades_broken == 0) and ($_ =~ /S/)){
      $spades_broken = 1;
    }
  }
  if ($var3 =~ /^\d+$/) {
    $spades_broken = 0;
  }
  elsif ($var3 ne "--"){
    delete $deck{$_};
    if (($spades_broken == 0) and ($_ =~ /S/)){
      $spades_broken = 1;
    }
  }
  if ($var1 =~ /^\d+$/) {
    $spades_broken = 0;
  }
  elsif ($var4 ne "--"){
    delete $deck{$_};
    if (($spades_broken == 0) and ($_ =~ /S/)){
      $spades_broken = 1;
    }
  }
}

@ARGV == 1 or die "Only accepts 1 file input.\n";

open( my $file, $ARGV[0]);

my $line = <$file>;

my @player_names = split ' ', $line;
my $column_count = 1;

while (<>) {
  next if $. == 1;
  $_ =~ /^\s*\d+\s+(\S+)\s+\d+\s+(\S+)\s+\d+\s+(\S+)\s+\d+\s+(\S+)\s*$/;
  $var1 = $1;
  $var2 = $2;
  $var3 = $3;
  $var4 = $4;
  &create_deck;
  &tally_bids;
  &is_broken;
}

print $player_names[1].":".$player_bids1."\n";
print $player_names[2].":".$player_bids2."\n";
print $player_names[3].":".$player_bids3."\n";
print $player_names[4].":".$player_bids4."\n";

if ($spades_broken == 0) {
  print "Spades have not been broken.\n";
}
else {
  print "Spades have been broken.\n";
}
