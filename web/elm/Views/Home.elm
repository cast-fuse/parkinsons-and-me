module Views.Home exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Components.SpeechHeader exposing (speechHeader)
import Helpers.Styles as Styles
import Model exposing (..)


home : Model -> Html Msg
home model =
    div []
        [ speechHeader "Wondering what happens next?"
        , div [ class "mw5 center" ]
            [ h2 [ class "ph3" ] [ text "We know that being diagnosed with Parkinson's can feel confusing and overwhelming. But there's lots of information and support out there, and we're here to help fin what's right for you, right" ]
            , button [ class Styles.buttonClear, onClick <| SetView Name ] [ text "Let's get started" ]
            ]
        ]
