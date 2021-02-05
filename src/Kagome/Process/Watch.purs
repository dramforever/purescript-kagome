module Kagome.Process.Watch where

import Prelude

import Kagome.Types.Process (Process(..), Result(..))
import Kagome.Types.Watch (class Watch, Sentinel(..), sentinel)

import Effect.Ref as Ref
import FRP.Event as Event

-- | `watchSentinel s`: Returns the current value of the `Sentinel` `s` and
-- | subscribe to its `onChange`. Backtracks every time `s` is updated, and
-- | returns the new value.
-- |
-- | See also: `watch`.
-- |
-- | - *Forward*: Gets and returns the `currentValue` of `s`.
-- | - *Backtracking*: Unsubscribes to `s.onChange`.
-- | - *Triggers backtrack*: Whenever `s.onChange` fires.
watchSentinel :: forall a. Sentinel a -> Process a
watchSentinel (Sentinel s) = Process \cont -> do
    val <- s.currentValue
    Result d r <- cont val
    dCont <- Ref.new d
    dEvent <- Event.subscribe s.onChange \val' -> do
        Result d' _ <- cont val'
        Ref.write d' dCont
    pure (Result (join (Ref.read dCont) *> dEvent) r)

-- | `watch w`: Returns the current value of the `w`, and subscribe to its
-- | changes. Backtracks every time `w` is updated, and returns the new value.
-- |
-- | - *Forward*: Gets and returns the currentValue of `w`.
-- | - *Backtracking*: Unsubscribes to the changes of `w`.
-- | - *Triggers backtrack*: Whenever `w` changes
watch :: forall w a. Watch w a => w -> Process a
watch = watchSentinel <<< sentinel
