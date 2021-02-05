module Kagome.Types.Process where

import Prelude

import Kagome.Types.Disposal (class Disposable, Disposal)

import Effect (Effect)
import Effect.Class (class MonadEffect)

data Result r = Result Disposal r

derive instance instanceFunctorResult :: Functor Result

instance instanceApplyResult :: Apply Result where
    apply (Result d1 r1) (Result d2 r2) = Result (d1 *> d2) (r1 r2)

instance instanceApplicativeResult :: Applicative Result where
    pure = Result (pure unit)

mapResultDisposal :: forall r.
    (Disposal -> Disposal) -> Result r -> Result r
mapResultDisposal f (Result d a) = Result (f d) a

instance instanceDisposableResult :: Disposable (Result r) where
    dispose (Result d _) = d

-- | The main `Monad` in which most actions in Kagome will take place.
-- |
-- | A function returning a `Process` should, in addition to the regular
-- | documentation elements, include the following points.
-- |
-- | - *Forward*: What this process does when executing.
-- | - *Backtracking*: What this process does when backtracking.
-- | - *Triggers backtrack*: What triggers a backtracking, or just 'Never.'
newtype Process a =
    Process (forall r.
        (a -> Effect (Result r)) -> Effect (Result r))

unwrapProcess :: forall a r.
    Process a -> (a -> Effect (Result r)) -> Effect (Result r)
unwrapProcess (Process p) = p

instance instanceFunctorProcess :: Functor Process where
    map = liftA1

instance instanceApplyProcess :: Apply Process where
    apply = ap

instance instanceApplicativeProcess :: Applicative Process where
    pure a = Process (\cont -> cont a)

instance instanceBindProcess :: Bind Process where
    bind (Process a) f = Process (\cont ->
        a (\v -> unwrapProcess (f v) cont))

instance instanceMonadProcess :: Monad Process

instance instanceMonadEffectProcess :: MonadEffect Process where
    liftEffect e = Process (e >>= _)
