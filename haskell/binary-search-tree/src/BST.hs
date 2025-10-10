module BST (
    BST,
    bstLeft,
    bstRight,
    bstValue,
    empty,
    fromList,
    insert,
    singleton,
    toList,
)
where

data BST a = BST
    { left :: Maybe (BST a)
    , right :: Maybe (BST a)
    , value :: Maybe a
    }
    deriving (Eq, Show)

bstLeft :: BST a -> Maybe (BST a)
bstLeft tree = left tree

bstRight :: BST a -> Maybe (BST a)
bstRight tree = right tree

bstValue :: BST a -> Maybe a
bstValue tree = value tree

empty :: BST a
empty =
    BST
        { left = Nothing
        , right = Nothing
        , value = Nothing
        }

fromList :: (Ord a) => [a] -> BST a
fromList xs = fromListAcc xs empty

fromListAcc :: (Ord a) => [a] -> BST a -> BST a
fromListAcc (x : xs) tree = fromListAcc xs (insert x tree)
fromListAcc [] tree = tree

insert :: (Ord a) => a -> BST a -> BST a
insert x tree =
    case (value tree) of
        (Just top) ->
            if x <= top
                then tree{left = Just (tryInsert x (left tree))}
                else tree{right = Just (tryInsert x (right tree))}
        Nothing ->
            tree{value = Just x, left = Just empty, right = Just empty}

tryInsert :: (Ord a) => a -> Maybe (BST a) -> BST a
tryInsert x (Just tree) = insert x tree
tryInsert x Nothing = empty{value = Just x, left = Just empty, right = Just empty}

singleton :: a -> BST a
singleton x = empty{value = Just x, left = Just empty, right = Just empty}

toList :: BST a -> [a]
toList tree = tryToList (Just tree)

tryToList :: Maybe (BST a) -> [a]
tryToList (Just tree) =
    case (value tree) of
        Just val -> tryToList (left tree) ++ val : tryToList (right tree)
        Nothing -> tryToList (left tree) ++ tryToList (right tree)
tryToList Nothing = []
