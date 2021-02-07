module Kagome.DOM.Tree where

import Kagome.DOM.Class
import Prelude

import Data.Foldable (traverse_)
import Data.Maybe (Maybe(..))
import Effect.Class (liftEffect)
import Kagome.Process (Process, registerDisposal)
import Web.DOM as DOM
import Web.DOM.Document as DOM
import Web.DOM.Node as DOM
import Web.HTML (window)
import Web.HTML.Window (document)

createElement :: String -> Process DOM.Element
createElement tag =
    liftEffect $ window >>= document >>= DOM.createElement tag

appendChild
    :: forall a b. Is DOM.Node a => Is DOM.Node b
    => a -> b -> Process Unit
appendChild a0 b0 = do
    original <- liftEffect $ DOM.parentNode a
    _ <- liftEffect $ DOM.appendChild a b
    registerDisposal
        case original of
            Nothing -> do
                cur <- DOM.parentNode a
                void $ traverse_ (DOM.removeChild a) cur
            Just node ->
                void $ DOM.appendChild a node
    where
        a = toNode a0
        b = toNode b0
