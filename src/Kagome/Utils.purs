module Kagome.Utils where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Exception (throw)
import FRP.Event (Event, makeEvent, subscribe)

fromJustEffect :: forall a. Maybe a -> Effect a
fromJustEffect (Just a) = pure a
fromJustEffect Nothing = throw "Nothing"

tagEvent :: forall a b. Effect (a -> b) -> Event a -> Event b
tagEvent tag event = makeEvent \handler ->
    subscribe event (\val -> ((_ $ val) <$> tag) >>= handler)
