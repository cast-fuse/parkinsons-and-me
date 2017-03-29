module Views.Home exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Components.Logo exposing (logo)
import Model exposing (..)


home : Model -> Html Msg
home model =
    div []
        [ logo
        , h1 [ class "blue" ] [ text <| String.toUpper <| "Hello and welcome to" ]
        , h2 [ class "blue" ] [ text "What3Things" ]
        , p [] [ text "Parkinson's UK offers a variety of support and information types for everyone." ]
        , p [] [ text "What3Things will ensure you get the best match for your needs right now." ]
        , button [ class "bg-dark-blue bn white ph4 pv3 f5", onClick <| SetView UserInfo ] [ text "Get Started" ]
        ]
