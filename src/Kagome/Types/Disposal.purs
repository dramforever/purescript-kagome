module Kagome.Types.Disposal where

import Effect (Effect)
import Prelude

type Disposal = Effect Unit

class Disposable a where
    dispose :: a -> Disposal
