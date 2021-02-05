module Kagome.Types.Event where

import Prelude

import Data.Array (deleteBy)
import Data.Foldable (traverse_)
import Effect (Effect)
import Effect.Ref as Ref
import FRP.Event (Event, makeEvent) as Event
import Unsafe.Reference (unsafeRefEq)

type EventDisposable a =
  { event :: Event.Event a
  , push :: a -> Effect Unit
  , clear :: Effect Unit
  }

createDisposable :: forall a. Effect (EventDisposable a)
createDisposable = do
  subscribers <- Ref.new []
  pure
    { event: Event.makeEvent \k -> do
        _ <- Ref.modify (_ <> [k]) subscribers
        pure do
          _ <- Ref.modify (deleteBy unsafeRefEq k) subscribers
          pure unit
    , push: \a -> do
        Ref.read subscribers >>= traverse_ \k -> k a
    , clear: Ref.write [] subscribers
    }
