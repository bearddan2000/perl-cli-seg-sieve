#!/usr/bin/env perl

our @prime = [];
# This functions finds all
# primes smaller than limit
# using simple sieve of eratosthenes.
# It stores found
# primes in vector prime[]
sub simpleSieve
{
  my $limit = shift;
  my @mark = [$limit + 1];
  @mark = (0) x @mark;

    for (my $i = 2; $i*$i <= $limit; ++$i)
    {
        if ($mark[$i] == 0)
        {
            # If not marked yet, then its a prime
            push(@prime, $i);
            for (my $j = $i; $j <= $limit; $j += $i)
            {
                  $mark[$j] = 1;
            }
        }
    }
}

# Finds all prime numbers
# in given range using
# segmented sieve
sub primesInRange
{
  my ($low, $high) = @_;
    # Compute all primes smaller or equal to
    # square root of high using simple sieve
    my $limit = int(sqrt($high)) + 1;
    &simpleSieve($limit);

    # Count of elements in given range
    my $n = $high - $low + 1;

    # Declaring boolean only for [low, high]
    my @mark = [$n + 1];
    @mark = (0) x @mark;

    # Use the found primes by
    # simpleSieve() to find
    # primes in given range
    for (my $i = 0; $i < scalar(@prime); $i++)
    {

        # Find the minimum number
        # in [low..high] that is
        # a multiple of prime[i]$
        # (divisible by prime[i])
        my $loLim = int($low / $prime[$i]) * $prime[$i];
        $loLim += $prime[$i] if ($loLim < $low);
        $loLim += $prime[$i] if ($loLim == $prime[$i]);

      #  Mark multiples of prime[i] in [low..high]:
        #  We are marking j - low for j, i.e. each number
        #  in range [low, high] is mapped to [0, high - low]
        #  so if range is [50, 100] marking 50 corresponds
        #  to marking 0, marking 51 corresponds to 1 and
        #  so on. Also if the current j is prime don't mark
        #  it as true.In this way we need
        #  to allocate space only for range
        for (my $j = $loLim; $j <= $high; $j += $prime[$i])
        {
          $mark[$j - $low] = 1 if($j != $prime[$i]);
        }
    }
    print "[OUTPUT] ";

    # Numbers which are not marked in range, are prime
    for (my $i = $low; $i <= $high; $i++)
    {
      printf "%d ", $i if($mark[$i - $low] == 0);
    }
    print "\n";
}
sub main {
  my $low = 10;
  my $high = 20;
  printf "[INPUT] low:%d\thigh:%d\n", $low, $high;
  &primesInRange($low, $high);
}
&main;
