{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "kagome"
, dependencies =
    [ "console"
    , "effect"
    , "psci-support"
    , "event"
    ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
