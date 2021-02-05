module Kagome.Process.Disposal where

import Prelude

import Kagome.Types.Process (Process(..), mapResultDisposal)
import Kagome.Types.Disposal (class Disposable, Disposal, dispose)

-- | `registerDisposal d`: Register the `Disposal` `d` to be called when
-- | backtracking.
-- |
-- | See also: `cleanup`.
-- |
-- | - *Forward*: Nothing.
-- | - *Backtracking*: Calls `d`.
-- | - *Triggers backtrack*: Never.
registerDisposal :: Disposal -> Process Unit
registerDisposal d = Process \cont ->
    mapResultDisposal (_ *> d) <$> cont unit

-- | `cleanup d`: Register the `Disposable` `d` to `dispose` of when
-- | backtracking.
-- |
-- | - *Forward*: Nothing.
-- | - *Backtracking*: Calls `dispose d`.
-- | - *Triggers backtrack*: Never.
cleanup :: forall a. Disposable a => a -> Process Unit
cleanup d = registerDisposal (dispose d)
