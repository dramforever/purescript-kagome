module Kagome.Misc.Interact where

import Kagome.Utils
import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Exception (throw)
import Kagome.DOM.Class (fromElement)
import Kagome.DOM.Input (getEvent)
import Kagome.DOM.Tree (appendChild, createElement, setTextContent)
import Kagome.Process (Process, watch)
import Kagome.Types.Watch (resampling)
import Web.DOM.Document (doctype)
import Web.HTML (HTMLElement, window)
import Web.HTML.HTMLDocument (body)
import Web.HTML.HTMLInputElement as Input
import Web.HTML.Window (document)

fromJustEffect :: forall a. Maybe a -> Effect a
fromJustEffect (Just a) = pure a
fromJustEffect Nothing = throw "Nothing"

getBody :: Effect HTMLElement
getBody = window >>= document >>= body >>= fromJustEffect

text :: String -> Process Unit
text content = do
    div <- createElement "div"
    setTextContent content div
    liftEffect getBody >>= appendChild div

input :: Process String
input = do
    inp0 <- createElement "input"
    inp <- liftEffect $ fromJustEffect (fromElement inp0)
    ev <- getEvent "input" inp
    liftEffect getBody >>= appendChild inp
    watch $ resampling (Input.value inp) (void ev)
