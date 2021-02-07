{ name = "kagome"
, dependencies =
    [ "console"
    , "effect"
    , "psci-support"
    , "event"
    , "web-dom"
    , "web-events"
    , "dom-indexed"
    ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
, license = "BSD-3-Clause"
}
