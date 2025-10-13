module Triangle (rows) where

rows :: Int -> [[Integer]]
rows n = take n pascal
  where
    pascal = [1] : map next pascal
    next r = zipWith (+) (0 : r) $ r ++ [0]
