module Kagome.Process.Run where

import Prelude

import Data.Maybe (Maybe(..), isJust)
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Exception (throw)
import Effect.Ref as Ref
import FRP.Event as Event
import Kagome.Types.Disposal (Disposal)
import Kagome.Types.Process (Process(..), Result(..), unwrapProcess)
import Kagome.Types.Watch (Sentinel(..))

process :: forall a. Process a -> Process (Sentinel a)
process (Process p) = do
    current <- liftEffect $ Ref.new Nothing
    { event, push } <- liftEffect $ Event.create

    Result d r <- liftEffect $ p \v -> do
            shouldPush <- isJust <$> Ref.read current
            when shouldPush (push v)
            Ref.write (Just v) current
            pure (pure v)

    pure $ Sentinel
        { currentValue: do
            val <- Ref.read current
            case val of
                Just v -> pure v
                Nothing -> throw "This shouldn't be possible"
        , onChange: event
        }

type ProcessResult a =
    { dispose :: Disposal
    , sentinel :: Sentinel a
    }

runProcess :: forall a. Process a -> Effect (ProcessResult a)
runProcess p = do
    Result dispose sentinel <- unwrapProcess (process p) (\v -> pure (pure v))
    pure { dispose, sentinel }
