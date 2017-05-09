module Views.Instructions exposing (instructions)

import Components.SpeechHeader exposing (speechHeader)
import Helpers.Styles exposing (buttonClear)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)


instructions : Model -> Html Msg
instructions model =
    div [ class "mw6 center" ]
        [ speechHeader "So, how do you work this thing?"
        , h3 [] [ text "We're going to share some quotes from real people - they've all been recently diagnosed too. Simply pick which ones sound like you." ]
        , h3 [] [ text "This will help use get a better picture of what information and support is right for you." ]
        , h3 [] [ text "Ready?" ]
        , button [ class buttonClear, onClick <| SetView Quotes ] [ text "Let's go" ]
        ]
