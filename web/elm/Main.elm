module Main exposing (..)

import Update exposing (..)
import Model exposing (..)
import View exposing (..)
import Navigation exposing (program)


main : Program Never Model Msg
main =
    program UrlChange
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }
