module Kagome.Types.Watch where

import Prelude

import Effect (Effect)
import FRP.Event (Event)

newtype Sentinel a = Sentinel
    { currentValue :: Effect a
    , onChange :: Event a
    }

class Watch w a | w -> a where
    sentinel :: w -> Sentinel a

instance instanceWatchSentinel :: Watch (Sentinel a) a where
    sentinel = identity
