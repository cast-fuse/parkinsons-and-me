module Components.Utils exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Model exposing (..)


emptyDiv : Html msg
emptyDiv =
    div [] []


outboundLink : String -> Html Msg -> Html Msg
outboundLink url body =
    a [ href url, onClick <| TrackOutboundLink url ] [ body ]
