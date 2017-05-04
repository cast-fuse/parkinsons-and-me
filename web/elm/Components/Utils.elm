module Components.Utils exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Model exposing (..)


emptyDiv : Html msg
emptyDiv =
    div [] []


outboundLink : String -> String -> Html Msg
outboundLink body url =
    a [ href url, onClick <| TrackOutboundLink url ] [ text body ]
