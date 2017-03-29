module Views.Quotes exposing (quotes)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Model exposing (..)


quotes : Model -> Html Msg
quotes model =
    div [] [ text "quotes page" ]
