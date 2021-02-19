module Main where

import Prelude

import Kagome.DOM.Tree
import Kagome.Misc.Interact
import Kagome.Process
import Kagome.Utils

import Effect (Effect)

proc :: Process Unit
proc = do
    name <- input
    text $ "Hello " <> name
    when (name == "secret") do
        text $ "Hey you found the secret entrance"
        text $ "How do you spell that?"
        word <- input
        if word == "that"
            then do
                text $ "Horray"
                text $ "Let's do that again"
                proc
            else
                when (word /= "") (text $ "Nope")


go :: Effect (ProcessResult Unit)
go = runProcess proc

main :: Effect Unit
main = void go
