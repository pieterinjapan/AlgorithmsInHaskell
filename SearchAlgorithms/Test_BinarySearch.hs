{-
Author  : Pieter van Wyk
Created : 2020-12-08
Updated : 2020-12-12

Property tests for binary search algorithm
-}
import Test.QuickCheck
import Data.List
import BinarySearch

-- Property Tests --
--------------------

-- element inserted at given index is found at that index
prop_binary_00 :: Int -> [Int] -> Bool
prop_binary_00 el ls = binarySearch (small_ls ++ el:large_ls) el == Just idx
  where small_ls = sort [x | x <- ls, x < el]
        large_ls = sort [x | x <- ls, x < el]
        idx = length small_ls

-- element not in list is never found
prop_binary_01 :: Int -> [Int] -> Bool
prop_binary_01 el ls = binarySearch (small_ls ++ large_ls) el == Nothing
  where small_ls = sort [x | x <- ls, x < el]
        large_ls = sort [x | x <- ls, x < el]
        idx = length small_ls

main = do
  quickCheck (withMaxSuccess 10000 prop_binary_00)
  quickCheck (withMaxSuccess 10000 prop_binary_01)
