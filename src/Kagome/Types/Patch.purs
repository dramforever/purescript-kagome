module Kagome.Types.Patch where

import Data.Monoid.Endo (Endo (..))
import Prelude

class Monoid p <= Patch p a | p -> a where
    patch :: p -> a -> a

instance instancePatchEndo :: Patch (Endo (->) a) a where
    patch (Endo f) x = f x

endoPatch :: forall p a. Patch p a => p -> Endo (->) a
endoPatch = Endo <<< patch
