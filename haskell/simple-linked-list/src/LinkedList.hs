module LinkedList (
    LinkedList,
    datum,
    fromList,
    isNil,
    new,
    next,
    nil,
    reverseLinkedList,
    toList,
)
where

data LinkedList a
    = Node (a, LinkedList a)
    | Empty
    deriving (Eq, Show)

datum :: LinkedList a -> a
datum (Node (a, _)) = a
datum Empty = error "Called datum on an empty list"

fromList :: [a] -> LinkedList a
fromList list = f list nil
  where
    f (x : xs) linkedList = new x (f xs linkedList)
    f [] linkedList = linkedList

isNil :: LinkedList a -> Bool
isNil Empty = True
isNil _ = False

new :: a -> LinkedList a -> LinkedList a
new x linkedList = Node (x, linkedList)

next :: LinkedList a -> LinkedList a
next (Node (_, list)) = list
next Empty = error "called next on an empty list"

nil :: LinkedList a
nil = Empty

reverseLinkedList :: LinkedList a -> LinkedList a
reverseLinkedList linkedList =
    fromList $ reverse $ toList $ linkedList

toList :: LinkedList a -> [a]
toList list = f list []
  where
    f (Node (x, linkedList)) out = x : (f linkedList out)
    f Empty out = out
