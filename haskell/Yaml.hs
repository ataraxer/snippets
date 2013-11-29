import qualified Data.Map as M
import Data.List
import Data.Yaml.Syck
import Control.Monad

data Node = YNil | YString String | YList [Node] | YMap (M.Map Node Node)
    deriving (Ord, Eq)

cleanYaml n = parseElem $ n_elem n
    where parseElem :: YamlElem -> Node
          parseElem ENil      = YNil
          parseElem (EStr b)  = YString $ unpackBuf b
          parseElem (ESeq xs) = YList   $ map cleanYaml xs
          parseElem (EMap xs) = YMap    $ M.fromList $ map proc xs
              where proc (k, v) = (cleanYaml k, cleanYaml v)

unwrapString (YString s) = Just s
unwrapString _ = Nothing

unwrapList (YList xs) = Just xs
unwrapList _ = Nothing

unwrapMap (YMap kv) = Just kv
unwrapMap _ = Nothing

lookupString s = M.lookup (YString s) >=> unwrapString
lookupList   s = M.lookup (YString s) >=> unwrapList

main = do
    parsed <- parseYamlFile "Full.yaml"
    clean_yaml <- return $ cleanYaml parsed
    putStrLn "Done!"
