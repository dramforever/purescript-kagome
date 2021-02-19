module Kagome.DOM.Input
    ( getEvent
    , getEventCapture
    ) where

import Prelude

import Effect.Class (liftEffect)
import FRP.Event (Event)
import Kagome.DOM.Class (class Is, toEventTarget)
import Kagome.Types.Event (createDisposable)
import Kagome.Types.Process (Process)

import Web.Event.Event as Web
import Web.Event.EventTarget as Web

getEventRaw :: forall a. Is Web.EventTarget a
    => String -> a -> Boolean -> Process (Event Web.Event)
getEventRaw name target0 capture = do
    { event, push, clear } <- liftEffect createDisposable
    listener <- liftEffect $ Web.eventListener push
    liftEffect $ Web.addEventListener (Web.EventType name) listener capture target
    pure event
    where target = toEventTarget target0

getEvent :: forall a. Is Web.EventTarget a
    => String -> a -> Process (Event Web.Event)
getEvent name target = getEventRaw name target false

getEventCapture :: forall a. Is Web.EventTarget a
    => String -> a -> Process (Event Web.Event)
getEventCapture name target = getEventRaw name target true
