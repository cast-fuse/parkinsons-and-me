module Views.Home exposing (..)

import Components.SpeechHeader exposing (speechHeader)
import Helpers.Styles as Styles exposing (classes)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Model exposing (..)


home : Model -> Html Msg
home model =
    div []
        [ speechHeader "Parkinson's and Me"
        , div [ class "mw6 center" ]
            [ h2 [ class "ph3 f5 f4-ns" ] [ text "Wondering what happens next?" ]
            , h2 [ class "ph3 f5 f4-ns" ] [ text "We know that being diagnosed with Parkinson's can feel confusing and overwhelming. We're here to help find what's right for you, right now." ]
            , h2 [ class "ph3 f5 f4-ns" ] [ span [ class "dark-blue" ] [ text "Parkinson's and Me" ], text " is simple and easy to use, and at the end you'll have a list of next steps." ]
            , button
                [ class <| classes [ Styles.buttonClear, "mt3" ]
                , onClick <| SetView Name
                ]
                [ text "Let's get started" ]
            ]
        ]
