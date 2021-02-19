module Kagome.DOM.Tree where

import Kagome.DOM.Class
import Prelude

import Data.Foldable (traverse_)
import Data.Maybe (Maybe(..))
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Kagome.Process (Process, registerDisposal)
import Web.DOM as DOM
import Web.DOM.Document as DOM
import Web.DOM.Element as DOM
import Web.DOM.Node as DOM
import Web.HTML (window)
import Web.HTML.Window (document)

createElement :: String -> Process DOM.Element
createElement tag =
    liftEffect $ window >>= document >>= toDocument >>> DOM.createElement tag

setTextContent :: forall a. Is DOM.Node a
    => String -> a -> Process Unit
setTextContent text n0 = do
    original <- liftEffect $ DOM.textContent n
    liftEffect $ DOM.setTextContent text n
    registerDisposal (DOM.setTextContent original n)
    where n = toNode n0

setAttribute :: forall a. Is DOM.Element a
    => String -> String -> a -> Process Unit
setAttribute key val e0 = do
    original <- liftEffect $ DOM.getAttribute key e
    liftEffect $ DOM.setAttribute key val e
    registerDisposal
        case original of
            Nothing -> DOM.removeAttribute key e
            Just orig -> DOM.setAttribute key orig e
    where e = toElement e0

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
