module Kagome.Types.Watch where

import Prelude

import Control.Alt ((<|>))
import Control.Plus (empty)
import Data.Function as Function
import Effect (Effect)
import Effect.Ref as Ref
import FRP.Event (Event)
import Kagome.Types.Disposal (Disposal)
import Kagome.Types.Event as Event
import Kagome.Utils (tagEvent)

newtype Sentinel a = Sentinel
    { current :: Effect a
    , onChange :: Event a
    }

class Watch w a | w -> a where
    sentinel :: w -> Sentinel a

instance instanceWatchSentinel :: Watch (Sentinel a) a where
    sentinel = identity

instance instanceFunctorSentinel :: Functor Sentinel where
    map f (Sentinel { current, onChange }) =
        Sentinel
            { current: f <$> current
            , onChange: f <$> onChange
            }

instance instanceApplySentinel :: Apply Sentinel where
    apply (Sentinel a) (Sentinel b) =
        Sentinel
            { current: a.current <*> b.current
            , onChange: tagEvent a.current b.onChange
                <|> tagEvent (flip Function.apply <$> b.current) a.onChange
            }

instance instanceApplicativeSentinel :: Applicative Sentinel where
    pure a =
        Sentinel
            { current: pure a
            , onChange: empty
            }

type SentinelWith a =
    { sentinel :: Sentinel a
    , push :: a -> Effect Unit
    , dispose :: Disposal
    }

createSentinel :: forall a. a -> Effect (SentinelWith a)
createSentinel a = do
    val <- Ref.new a
    { event, push, clear } <- Event.createDisposable
    pure
        { sentinel: Sentinel
            { current: Ref.read val
            , onChange: event
            }
        , push: \a' -> do
            Ref.write a' val
            push a'
        , dispose: clear
        }

resampling :: forall a. Effect a -> Event Unit -> Sentinel a
resampling sample onChange = do
    Sentinel
        { current: sample
        , onChange: tagEvent (const <$> sample) onChange
        }
