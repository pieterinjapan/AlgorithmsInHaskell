{-
Author  : Pieter van Wyk
Created : 2020-12-18
Updated : 2020-12-18

Property tests for prime number test and generation algorithms
-}
import PrimeNumbers
import Test.QuickCheck

-- Helper Functions --
----------------------

-- helper function to determine if all elements in a list are coprime
checkCoprime :: [Int] -> Bool
checkCoprime [] = True
checkCoprime [_] = True
checkCoprime (n:ns) = all (\x -> gcd n x == 1) ns && checkCoprime ns

-- Property Tests --
--------------------

-- for a given number num and its factor n, check that
-- after n is not a factor of the result of divideOut
prop_divideOut_00 :: Int -> Int -> Bool
prop_divideOut_00 n num = mod (divideOut n' num') n' /= 0
  where n' = max 2 (abs n)
        num' = max 1 (abs num)

-- check that for any list generated by primeFact, all elements are coprime
prop_primeFact_00 :: Int -> Bool
prop_primeFact_00 num = checkCoprime (primeFact num')
  where num' = max 2 (abs num)

-- check that isPrime gives True for prime numbers
prop_isPrime_00 :: Int -> Bool
prop_isPrime_00 num = and $ map isPrime primes
  where primes = primeFact (max 2 (abs num))

-- check that isPrime gives False for composite numbers
prop_isPrime_01 :: Int -> Int -> Bool
prop_isPrime_01 num1 num2 = not $ isPrime (num1'*num2')
  where num1' = max 2 (abs num1)
        num2' = max 2 (abs num2)

main = do
  quickCheck (withMaxSuccess 10000 prop_divideOut_00)
  quickCheck (withMaxSuccess 10000 prop_primeFact_00)
  quickCheck (withMaxSuccess 10000 prop_isPrime_00)
  quickCheck (withMaxSuccess 10000 prop_isPrime_01)
